% 
% Alpication
% Copyright 2014, 2017-2018 Mirko Bunse
% 
% 
% Do your job application easily with Alpication: Just set the needed parameters and fill the (two) provided
% environments with content - there you go! See the README.md for further usage instructions.
% 
% 
% Alpication is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with Alpication.  If not, see <http://www.gnu.org/licenses/>.
% 

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{alpication}[2018/10/13 Alpication]

\newwrite\apxList % temporary file for appendix list

%
% dependencies
%
	\LoadClass[a4paper, 11pt]{article}

	\RequirePackage{environ}
	\RequirePackage[left=30mm,right=25mm,top=18mm,bottom=34mm]{geometry}
	\RequirePackage{currvita}
	\RequirePackage{ifthen}
	\RequirePackage{wrapfig}
	\RequirePackage{graphicx}
	\RequirePackage{fancyhdr}
	\RequirePackage{eso-pic}
	\RequirePackage[hidelinks]{hyperref}
	\RequirePackage{pdfpages}
	\RequirePackage{enumitem}
	\RequirePackage{tikz}
	\RequirePackage[light, scale=0.92]{montserrat}
	\RequirePackage{eso-pic}
	\RequirePackage{marvosym}


% left CV column style
	\newlength{\leftColumnWidth}
	\setlength{\leftColumnWidth}{.3\paperwidth}
	\usetikzlibrary{patterns}
	\tikzstyle{header} = [
	  fill=blue!5,
	  postaction={pattern=north east lines, pattern color=blue!1}
	]
	\tikzstyle{footer} = [header]
	\tikzstyle{left cv column} = [header]
	
%
% internationalization
%
	% english (default)
	\newcommand{\Lpage}{Page}
	\newcommand{\Lpersinfo}{Personal Information}
	\newcommand{\Lcurrvitae}{Curriculum Vitae}
	\newcommand{\Ltelephone}{Telephone}
	\newcommand{\Lmail}{E-mail}
	\newcommand{\Lborn}{Born on}
	\newcommand{\Lin}{in}
	\newcommand{\Lthe}{}
	\newcommand{\Lappendix}{Appendix}
	\newcommand{\Lmotivation}{Motivation}
	
	% german
	\DeclareOption{german}{
		\renewcommand{\Lpage}{Seite}
		\renewcommand{\Lpersinfo}{Pers\"onliche Informationen}
		\renewcommand{\Lcurrvitae}{Lebenslauf}
		\renewcommand{\Ltelephone}{Telefon}
		\renewcommand{\Lborn}{Geb. am}
		\renewcommand{\Lin}{in}
		\renewcommand{\Lthe}{den}
		\renewcommand{\Lappendix}{Anhang}
		\renewcommand{\Lmotivation}{Motivationsschreiben}
	}
	
	% To implement your own language, specify here as seen for german
	
	\ProcessOptions

%
% applicant information
%
	% standard values for info that can be left out
	\newcommand{\aPicture}{}
	\newcommand{\aSign}{}
	\newcommand{\toAddr}{}
	\newcommand{\aXING}{}
	\newcommand{\aLinkedIn}{}
	\newcommand{\aGitHub}{}
	\newcommand{\aBirthday}{}
	\newcommand{\aBirthplace}{}
	\newcommand{\aFamilyStatus}{}
	\newcommand{\aNationality}{}
	
	\newcommand{\applicantName}[1]{\newcommand{\aName}{#1}}
	\newcommand{\applicantStreet}[1]{\newcommand{\aStreet}{#1}}
	\newcommand{\applicantCity}[1]{\newcommand{\aCity}{#1}}
	\newcommand{\applicantPhone}[1]{\newcommand{\aPhone}{#1}}
	\newcommand{\applicantMail}[1]{\newcommand{\aMail}{#1}}
	\newcommand{\applicantXING}[1]{\renewcommand{\aXING}{#1}}
	\newcommand{\applicantLinkedIn}[1]{\renewcommand{\aLinkedIn}{#1}}
	\newcommand{\applicantGitHub}[1]{\renewcommand{\aGitHub}{#1}}
	
	\newcommand{\applicantPosition}[1]{\newcommand{\aPosition}{#1}}
	
	\newcommand{\applicantPicture}[1]{\renewcommand{\aPicture}{#1}}
	\newcommand{\applicantSign}[1]{\renewcommand{\aSign}{#1}}
	\newcommand{\signCity}[1]{\newcommand{\sCity}{#1}}
	
	\newcommand{\applicantBirthday}[1]{\renewcommand{\aBirthday}{#1}}
	\newcommand{\applicantBirthplace}[1]{\renewcommand{\aBirthplace}{#1}}
	\newcommand{\applicantFamilyStatus}[1]{\renewcommand{\aFamilyStatus}{#1}}
	\newcommand{\applicantNationality}[1]{\renewcommand{\aNationality}{#1}}
	
	\newcommand{\toAddress}[1]{\renewcommand{\toAddr}{#1}}


%
% basic styling
%
	\colorlet{lightblack}{black!95}
	\newcommand{\heading}[1]{{\sffamily\fontseries{sb}\selectfont\color{lightblack}#1}}
	\renewcommand*{\cvlistheadingfont}{\sffamily\fontseries{sb}\selectfont\color{black!98}}
	\newcommand{\cunderline}[2]{\textcolor{#1}{ \underline{\textcolor{black}{#2}} }}
	
%
% beginning and end of document
%
	\AtBeginDocument{

		% background for header and footer
		\AddToShipoutPictureBG{%
			\begin{tikzpicture}[remember picture,overlay]

				% header
				\coordinate (header south west) at ([yshift=-19mm] current page.north west);
				\coordinate (header south east) at ([yshift=-19mm] current page.north east);
				\fill[header]
				  (current page.north east) -- (current page.north west) -- (header south west) -- (header south east) -- cycle;
				% \draw[thick, black!4] (header south west) -- (header south east);

				% footer
				\coordinate (footer north west) at ([yshift=21mm] current page.south west);
				\coordinate (footer north east) at ([yshift=21mm] current page.south east);
				\fill[footer]
				  (footer north east) -- (footer north west) -- (current page.south west) -- (current page.south east) -- cycle;
				% \draw[thick, black!4] (footer north west) -- (footer north east);

		
			\end{tikzpicture}%
		}
		
		% open appendix list writer
		\openout\apxList=\jobname.apx	% not opening immediately allows to input the file to produce a list
		\write\apxList{\textbf{\Lappendix:}}
		\write\apxList{\string\begin{itemize}[nosep]}
		
		% parskip and -indent
		\setlength{\parskip}{8pt}
		\setlength{\parindent}{0pt}
		
		% pagestyle, head and foot
		\pagestyle{fancy}
		\setlength{\headheight}{24pt}
		\setlength{\headsep}{36pt}
		\renewcommand{\headrule}{}
		
		\lhead{}
		\rhead{\sffamily\fontseries{el}\selectfont\Large\color{lightblack}\aName}

		\lfoot{\sffamily\fontseries{el}\selectfont\small\color{lightblack}\aName}
		\cfoot{\sffamily\fontseries{el}\selectfont\small\color{lightblack}\aStreet~\\\aCity}
		\rfoot{\sffamily\fontseries{el}\selectfont\small\color{lightblack}\aPhone~\\\href{mailto:\aMail}{\aMail}}
		
	}
	
	\AtEndDocument{
		
		\immediate\write\apxList{\string\end{itemize}}
		\immediate\closeout\apxList
		
	}
	
%
% correspondence environment
%
	\newenvironment{correspondence}[1]
	% on begin
	{
	
		\lhead{}
	
		% the addresses
	
		\vspace*{0mm}
		
		\ifthenelse{\equal{\toAddr}{}}{}
		{ % only print addresses, if actually defined
			\cunderline{lightblack}{\sffamily\footnotesize\aName, \aStreet, \aCity} % applicant address
			
			{\toAddr}		% addressees address
		}
	
		\vspace{6mm}

		\begin{flushright}		% the date
			\today
		\end{flushright}
	
		\vspace{0mm}
		
		% the correspondence
	
		\heading{\large#1} % the subject

		\vspace{1em}
		
	}
	% on end
	{
		
		\pagebreak
		
	}
	
%
% opening / closing commands for the correspondence
%
	\newcommand{\opening}[1]{#1\vspace{.33em}}
	\newcommand{\closing}[1]{%
	
		\vspace{.33em}#1
		
		\ifthenelse{\equal{\aSign}{}}{\vspace{6mm}}
		{ % only print signet, if actually defined
			\vspace{.33em}
			\includegraphics{\aSign}
			
			\vspace{-16mm}
		}
			
		\rule{0.3\textwidth}{0.4pt}
		
		\vspace{-3mm}
			
		\aName
		
	}
	
% 
% motivation environment (may be relevant for university and internship applications)
% 
	\newenvironment{motivation}
	% on begin
	{
		
		\lhead{\sffamily\fontseries{el}\selectfont\color{lightblack}\Lpage~\thepage}
		
		\heading{\large\Lmotivation} % \Large
		
		% \vspace{8mm}
		
	}
	% on end
	{
		\pagebreak
	}
	
%
% curriculum vitae section environment
%
	\newenvironment{cvsection}[1]
	% on begin
	{
		\begin{cvlist}{#1}
		\setlength{\baselineskip}{1.25em}
		\setlength{\itemsep}{0.25em}
	}
	% on end
	{
		\end{cvlist}
	}

%
% main curriculum vitae environment
%
	\newcommand{\leftColumnPicture}{%
		\begin{tikzpicture}
			\node[
			  fill=white,
			  inner sep=2mm,
			  outer sep=0mm,
			  rounded corners,
			  text width=.2\paperwidth
			] (applicant picture) at (0,0)
			{\includegraphics[width=.2\paperwidth]{\aPicture}};
		\end{tikzpicture}
	}

	\newcommand{\makeCV}[2]{%
		
		\newgeometry{margin=0pt}
		\fancyhf{} % clear all header and footers
		\ClearShipoutPicture % remove background (header and footer boxes)

		\begin{tikzpicture}
			\tikzstyle{left cv column default} = [
			  text width=\leftColumnWidth-12mm,
			  anchor=north west,
			  inner sep=12mm
			]

			\node[
			  left cv column default,
			  text depth=\pdfpageheight-25mm,
			  minimum height=\pdfpageheight,
			  left cv column
			] (left column fill) at (current page.north west) {}; % just the fill

			\node[
			  left cv column default,
			  text width=\leftColumnWidth
			] (left column) at (current page.north west) {

				% content of left column
				#1

			};

			\node[
			  text width=\paperwidth-\leftColumnWidth,
			  anchor=north west,
			  inner xsep=6mm,
			  inner ysep=9mm
			] (cv) at (left column fill.north east) {

				% content of right column
				#2

			};
		\end{tikzpicture}

	}

% 
% appendix commands with automatic list
% 
	\newcommand{\apxFolder}{.}
	\newcommand{\appendixFolder}[1]{\renewcommand{\apxFolder}{#1}}
	
	\newcounter{apxRefCounter}
	
	\newcommand{\append}[2]{%
	  \immediate\write\apxList{\noexpand\item \string\hyperlink{apxRefCounter\theapxRefCounter.1}{#1}} % append name to file
	  \ClearShipoutPicture % remove background (header and footer boxes)
	  \includepdf[pages=-,link,linkname={apxRefCounter\theapxRefCounter}]{\apxFolder/#2}
	  \refstepcounter{apxRefCounter}
	}
	
	% read appendix list from file if it exists. Otherwise, emit a warning.
	\newcommand{\appendixList}{\IfFileExists{\jobname.apx}{%
	  \vspace*{8mm}
	  \input\jobname.apx
	}{%
	  \ClassWarning{alpication}{File \jobname.apx is missing. Re-run to get references right.}
	}}
