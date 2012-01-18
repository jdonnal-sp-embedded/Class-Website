\NeedsTeXFormat{LaTeX2e}
% Note:  leave the date in there even though it's dumb
\ProvidesClass{6115report}[2004/02/20 6.115 Lab Report Class, by Ryan Williams]

% Give status string
\typeout{$Id: 6115report.cls 4326 2007-02-13 11:13:13Z avestruz $}

\RequirePackage{epsfig}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsbsy}
\RequirePackage[mathscr]{eucal}
\RequirePackage{setspace}
\RequirePackage{ifthen}
\RequirePackage{textcomp}
\RequirePackage{xspace}
\RequirePackage{epsfig}
\RequirePackage{fancyheadings}
\RequirePackage{alltt}
\RequirePackage{graphicx}

% The following define how the package responds to options passed 
% in the user's lab like: \usepackage[lab2]{6115report}.  The LATE
% headers are to catch when someone forgets to change the option to
% the lab they are currently doing.

\newcommand{\labnumber}{Unknown Lab}
% -------------------  Normal Headers ------------------------------
\DeclareOption{lab1}{\renewcommand{\labnumber}{Lab 1 Report\xspace}}
\DeclareOption{lab2}{\renewcommand{\labnumber}{Lab 2 Report\xspace}}
\DeclareOption{lab3}{\renewcommand{\labnumber}{Lab 3 Report\xspace}}
\DeclareOption{lab4}{\renewcommand{\labnumber}{Lab 4 Report\xspace}}
\DeclareOption{lab5}{\renewcommand{\labnumber}{Lab 5 Report\xspace}}
\DeclareOption{lab6}{\renewcommand{\labnumber}{Lab 6 Report\xspace}}
\DeclareOption{proposal}{\renewcommand{\labnumber}{Final Project Proposal\xspace}}
\DeclareOption{final}{\renewcommand{\labnumber}{Final Project Report\xspace}}
%--------------------- LATE Headers -------------------------------
%\DeclareOption{lab1}{\renewcommand{\labnumber}{Lab 1 Report \textbf{LATE}\xspace}}
%\DeclareOption{lab2}{\renewcommand{\labnumber}{Lab 2 Report \textbf{LATE}\xspace}}
%\DeclareOption{lab3}{\renewcommand{\labnumber}{Lab 3 Report \textbf{LATE}\xspace}}
%\DeclareOption{lab4}{\renewcommand{\labnumber}{Lab 4 Report \textbf{LATE}\xspace}}
%\DeclareOption{lab5}{\renewcommand{\labnumber}{Lab 5 Report \textbf{LATE}\xspace}}
%\DeclareOption{lab6}{\renewcommand{\labnumber}{Lab 6 Report \textbf{LATE}\xspace}}
%\DeclareOption{proposal}{\renewcommand{\labnumber}{Final Project Proposal\textbf{LATE}\xspace}}

%-------------------- Error Correction ------------------------------
\DeclareOption*{\renewcommand{\labnumber}{Incorrect Option}\ClassWarning{6115report}{You passed the option '\CurrentOption' when we were expecting lab1, lab2, lab3, lab4, lab5, lab6, proposal, final}}
\ProcessOptions
%--------------------------------------------------

% Based on Article class
\LoadClass{article}

% These can put commands right after \begin{document} and after \end{document}
\AtBeginDocument{\thispagestyle{empty}\title{6.115 \labnumber}\author{\myname}\maketitle}
\AtEndDocument{\vspace{.1in}END OF LAB REPORT}

% Reusable commands that students should redefine with their own names
\newcommand{\myname}{J. Random Hacker}
\newcommand{\email}{6.115-tas@mit.edu}

% Set some sizes
\renewcommand{\normalsize}{\fontsize{10}{12}\selectfont}
\setlength{\textwidth}{6in}
\setlength{\textheight}{9.25in}
\setlength{\topmargin}{-0.5in}
\setlength{\headsep}{12pt}
\setlength{\footskip}{18pt}
\setlength{\oddsidemargin}{0in}
\setlength{\evensidemargin}{0in}
\setlength{\marginparwidth}{71pt}

% Headers and footers
\pagestyle{fancyplain}
\lhead[]{\fancyplain{}{\emph{6.115 \labnumber}}}
\rhead[]{\fancyplain{}{\textbf{\myname}, \email}}
\cfoot[\fancyplain{}{\thepage}]{\fancyplain{}{\thepage}}

% Convenience commands for exercises
\newcounter{excounter}
\setcounter{excounter}{1}
\newcommand{\exercise}[1][\theexcounter]{{\vspace{10pt}\noindent\Large\textbf{Exercise #1}.\par\vspace{10pt}}\addtocounter{excounter}{1}}

\renewcommand{\bold}[1]{\pmb{#1}}%  OK, this is cheesy

% For neat code display
\newenvironment{code}{%
% This code gets run at the start of the environment
\par\noindent\begin{center}%
\vspace{-6pt}\begin{list}{}{% For indenting
\setlength{\leftmargin}{1in}%
\setlength{\labelsep}{0pt}%
\setlength{\topsep}{0pt}%
\setlength{\parskip}{0pt}%
\setlength{\partopsep}{0pt}%
\setlength{\rightmargin}{\leftmargin}}%
\item[]\ignorespaces\hrulefill%
\begin{alltt}
}{%
% This code gets run at the end of the environment
	\end{alltt}\vspace{-6pt}\hrulefill%
\unskip\end{list}\end{center}
}

% For inclusion of figures
% run it as \figure[graphicx options]{file}{caption}{label}
\newcommand{\graphics}[4][keepaspectratio]{%
\begin{figure}[htbp]
\begin{center}%
\includegraphics[#1]{#2}%
\end{center}%
\caption{#3}%
\label{#4}%
\end{figure}}

