% Giordano Scarciotti
% https://www.imperial.ac.uk/people/g.scarciotti
% LaTeX class for the final report of the MSc degrees of the Electrical and Electronic Engineering Department at Imperial College London
% Version 1.0.1 - 09/06/2023
% Approved by the EEE Department

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% DO NOT MODIFY THIS FILE %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\PassOptionsToPackage{dvipsnames}{xcolor}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ic_eee_thesis}[2023/06/09 - Giordano Scarciotti - Imperial College London Thesis Format]
\LoadClass[a4paper]{book}

\RequirePackage{pgfcore}
\RequirePackage{geometry} 
\RequirePackage{bookmark}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{kantlipsum}

\RequirePackage{fontspec}

\RequirePackage{polyglossia}
\setdefaultlanguage{english}

\RequirePackage{minitoc}

\makeatletter
\def\input@path{{chapters/}}
\makeatother

\RequirePackage[printonlyused]{acronym}

\RequirePackage{ifthen}
\newboolean{list_of_tables}
\newboolean{list_of_figures}
\newboolean{acknowledgement}
\newboolean{acronyms}



\newlength{\logowidth}    \setlength{\logowidth}{70mm}
\newlength{\logopad}      \setlength{\logopad}{17.5mm}
\newlength{\marginleft}   \setlength{\marginleft}{3cm}   % Minimum margins are 2cm
\newlength{\marginright}  \setlength{\marginright}{3cm} 
\newlength{\margintop}    \setlength{\margintop}{3cm}
\newlength{\marginbottom} \setlength{\marginbottom}{3cm}  
\newlength{\marginhead} \setlength{\marginhead}{1cm}
\newlength{\marginfoot} \setlength{\marginfoot}{0.8cm}

\geometry{a4paper, top=\margintop, left=\marginleft, right=\marginright, bottom=\marginbottom, headsep=\marginhead, footskip=\marginfoot, nomarginpar}

\setlength{\parskip}{2ex plus 0.5ex minus 0.2ex}

%% Title page
\makeatletter
\def\course#1{\gdef\@course{#1}}
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\cid#1{\gdef\@cid{#1}}
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\submityear#1{\gdef\@submityear{#1}}

\newcommand{\titletext}{A Thesis submitted in fulfillment of requirements for the degree of\ \linebreak \textbf{Master of Science in \@course}}


\def\maketitle{
  \begin{titlepage}
    \hypertarget{TitlePage}{}
    \bookmark[dest=TitlePage,level=-1]{Front matter}
	\phantomsection \pdfbookmark[section]{Title page}{title}
    \pgfdeclareimage[width=\logowidth]{IC_Logo}{IC_Logo}
    \pgftext[at=\pgfpoint{-\marginleft+\logopad}{\margintop+\parskip-\logopad}, top, left]{\pgfuseimage{IC_Logo}}

    \begin{center}
	  \vspace*{\fill}
    \vskip 2cm
      \doublespacing {\huge  \textsc \@title } \par\singlespacing
      \vskip 0.5cm
      {\Large \textsc \@subtitle}
      \vskip 2cm
      Author\\[2mm]
      {\large \textsc \@author}\\[1mm]
      {\normalsize CID: \@cid}
      \vskip 1cm
      Supervised by\\[2mm]
      {\large \textsc \@supervisor}\\[1mm]
      \vskip 5cm
      \titletext
	  \vskip 0.5cm
	  Department of Electrical and Electronic Engineering\\
   Imperial College London\\
   \@submityear
      \vspace*{\fill}
    \end{center}
  \end{titlepage}
  
  \pagenumbering{arabic}
  \setcounter{page}{2} % ensure no number on title page, numbers on other pages match those in the PDF
}
\makeatother


\RequirePackage{silence}
\WarningsOff[everypage]
\RequirePackage[contents={},opacity=1,scale=1,color=black]{background}
\WarningsOn[everypage]


\RequirePackage{xpatch}
\makeatletter
\xpatchcmd{\chapter}{\thispagestyle{plain}}
                    {\thispagestyle{empty}\stepcounter{counter}}
                    {}{}
\makeatother

\RequirePackage{tikzpagenodes}
\RequirePackage{totcount}

\regtotcounter{counter}
\newcounter{counter}


\usetikzlibrary{calc}
\usetikzlibrary{shapes.symbols} 
\usetikzlibrary{shapes.misc} 

\RequirePackage{fancyhdr}

\definecolor{ImperialBlue}{RGB}{0,62,116}

\setlength{\headheight}{21pt}
\fancypagestyle{fancy}{
\fancyhead{}
\fancyfoot{}
\fancyhead[RE]{\color{ImperialBlue}\leftmark}
\fancyhead[LE]{\color{ImperialBlue}\thepage}
\fancyhead[RO]{\color{ImperialBlue}\thepage}
\fancyhead[LO]{\color{ImperialBlue}\rightmark}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\headrule}{\hbox to\headwidth{%
  \color{ImperialBlue}\leaders\hrule height \headrulewidth\hfill}}
\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyhead[LE]{\color{ImperialBlue}\thepage}
  \fancyhead[RO]{\color{ImperialBlue}\thepage}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\headrule}{\hbox to\headwidth{%
  \color{ImperialBlue}\leaders\hrule height \headrulewidth\hfill}}
\renewcommand{\footrulewidth}{0pt}
  \Materialfalse
  \afterpage{\Materialtrue}%
}
\fancypagestyle{empty}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0.0pt}%
  \Materialfalse
  \afterpage{\Materialtrue}%
}



\newif\ifMaterial

\newlength\LabelSize
\setlength\LabelSize{1.5cm}


\AtBeginDocument{%
  \setlength\LabelSize{\dimexpr\textheight/\totvalue{counter}\relax}%
  \ifdim\LabelSize>1.5cm\relax
  \global\setlength\LabelSize{1.5cm}%
  \fi
}
\makeatletter
\newcommand\AddLabels{%
  \Materialtrue
  \AddEverypageHook{%
    \ifMaterial
    \ifodd\value{page}%
    \backgroundsetup{
      angle=0,
      position={current page.east|-current page text area.north east},
      vshift=0pt-(\thecounter-2)*45pt,
      hshift=-15,
      contents={%
        \tikz\node[cho label] {\thechapter};
      }%
    }%
    \else
    \backgroundsetup{
      angle=0,
      position={current page.west|-current page text area.north west},
      vshift=0pt-(\thecounter-2)*45pt,
      hshift=15,
      contents={%
        \tikz\node[che label] {\thechapter};
      }%
    }%
    \fi
    \BgMaterial
    \else\relax\fi
  }%
}
\makeatother
\tikzset{
  che label/.style={fill,rounded rectangle, fill=ImperialBlue,anchor=west,text width=\LabelSize, align=right,text height=30pt,text depth=15pt,text=white,font=\sffamily\fontsize{25pt}{0pt}\selectfont},
}
\tikzset{
  cho label/.style={fill,rounded rectangle, fill=ImperialBlue,anchor=west,text width=\LabelSize, align=left,text height=30pt,text depth=15pt,text=white,font=\sffamily\fontsize{25pt}{0pt}\selectfont},
}

\newcommand\RemoveLabels{\Materialfalse}


\RequirePackage{titlesec}
\titleformat{\chapter}[display]
  {\normalfont\fontsize{90}{92}\raggedleft\bfseries\color{ImperialBlue}}{\ \thechapter}{-50pt}{\Huge\raggedleft\color{ImperialBlue}}
\titlespacing*{\chapter}{0pt}{0pt}{20pt}


\def\preamble{
\dominitoc % Do not change - required
\maketitle % Do not change - required

\pagestyle{empty} % Do not change - required
\frontmatter % Do not change - required
\doublespace % Do not change - required

\pagestyle{plain} % Do not change - required


\cleardoublepage\phantomsection
\addcontentsline{toc}{chapter}{Abstract}\mtcaddchapter 
\chapter*{Abstract}
\addtocounter{counter}{-1}
\input{Abstract.tex} % Do not remove


\input{OrigSta_Copyright.tex} % Do not remove
\ifthenelse{\boolean{acknowledgement}}{
\cleardoublepage\phantomsection
\addcontentsline{toc}{chapter}{Acknowledgments}\mtcaddchapter 
\chapter*{Acknowledgments}
\addtocounter{counter}{-1}
\input{Acknowledgement.tex} % OPTIONAL CAN BE REMOVED
}{}

\singlespace % Do not change - required
\tableofcontents % Do not change - required

\ifthenelse{\boolean{acronyms}}{
\cleardoublepage\phantomsection
\addcontentsline{toc}{chapter}{List of Acronyms}\mtcaddchapter 
\chapter*{List of Acronyms}
\addtocounter{counter}{-1}
\input{chapters/ListAcronyms.tex} % OPTIONAL CAN BE REMOVED
}{}

\ifthenelse{\boolean{list_of_figures}}{
\cleardoublepage\phantomsection
\addcontentsline{toc}{chapter}{\listfigurename}
\listoffigures % Optional
\addtocounter{counter}{-1}
}{}

\ifthenelse{\boolean{list_of_tables}}{
\cleardoublepage\phantomsection
\addcontentsline{toc}{chapter}
{\listtablename}
\listoftables
\addtocounter{counter}{-1}
}{} % OPTIONAL CAN BE ADDED

\doublespace % Do not change - required

\mainmatter % Do not change - required
\pagestyle{fancy} % Do not change - required
\AddLabels % Do not change - required

}


\def\conclusions{
\cleardoublepage % Do not change - required
\RemoveLabels % Do not change - required
\cleardoublepage\phantomsection
\addcontentsline{toc}{chapter}{Conclusions}\mtcaddchapter 
\chapter*{Conclusions}
\markboth{{CONCLUSIONS}}{CONCLUSIONS}
\addtocounter{counter}{-1}
% Edit the content of these files 
\input{Conclusions} % Do not remove
\cleardoublepage % Do not change - required
\AddLabels % Do not change - required
}