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


% tikz
	\usetikzlibrary{patterns}
	\tikzstyle{left cv column} = [
	  fill=blue!5,
	  postaction={pattern=north west lines, pattern color=blue!1}
	]
	
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
% beginning and end of document
%
	\colorlet{lightblack}{black!95}
	\colorlet{rulecolor}{lightblack} % default
	\newlength{\rulewidth}
	\setlength{\rulewidth}{.2pt}
	\newcommand{\cunderline}[2]{\textcolor{#1}{ \underline{\textcolor{black}{#2}} }}
			
	\AtBeginDocument{

		\sffamily

		% background for header and footer
		\AddToShipoutPictureBG{%
			\begin{tikzpicture}[remember picture,overlay]

				% header
				\coordinate (header south west) at ([yshift=-19mm] current page.north west);
				\coordinate (header south east) at ([yshift=-19mm] current page.north east);
				\fill[blue!5, postaction={pattern=north west lines, pattern color=blue!1}]
				  (current page.north east) -- (current page.north west) -- (header south west) -- (header south east) -- cycle;
				% \draw[thick, black!4] (header south west) -- (header south east);

				% footer
				\coordinate (footer north west) at ([yshift=21mm] current page.south west);
				\coordinate (footer north east) at ([yshift=21mm] current page.south east);
				\fill[blue!5, postaction={pattern=north west lines, pattern color=blue!1}]
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
		% \renewcommand{\headrulewidth}{\rulewidth}
		% \renewcommand{\headrule}{\vspace*{-5pt}\hbox to\headwidth{\color{rulecolor}\leaders\hrule height \headrulewidth\hfill}}
		\renewcommand{\headrule}{}
		
		\lhead{}
		\rhead{\sffamily\fontseries{el}\selectfont\Large\color{lightblack}\aName}
		
		% \renewcommand{\footrulewidth}{\rulewidth}
		% \renewcommand{\footrule}{\hbox to\headwidth{\color{rulecolor}\leaders\hrule height \footrulewidth\hfill}\vspace*{-2pt}}

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
			\cunderline{rulecolor}{\footnotesize\aName, \aStreet, \aCity}	% applicant address
			
			{\toAddr}		% addressees address
		}
	
		\vspace{8mm}

		\begin{flushright}		% the date
			\today
		\end{flushright}
	
		\vspace{0mm}
		
		% the correspondence
	
		{\color{lightblack}\fontseries{sb}\selectfont\large#1}		% the subject

		% \vspace{8mm}
		
	}
	% on end
	{
		
		\pagebreak
		
	}
	
%
% opening / closing commands for the correspondence
%
	\newcommand{\opening}[1]{#1\vspace{4mm}}
	\newcommand{\closing}[1]{%
	
		\vspace{4mm}#1
		
		\ifthenelse{\equal{\aSign}{}}{\vspace{8mm}}
		{ % only print signet, if actually defined
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
		
		{\color{lightblack}\fontseries{sb}\selectfont\Large\Lmotivation.} % \Large
		
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
	\newcommand{\leftColumnBlock}[2][]{%
		\node[left cv column default, inner ysep=0mm]
		  (last left column block) at (leftcol fill.west|-next left column anchor)
		  {%
		    \fontsize{12pt}{21pt}\selectfont%
		    \ifthenelse{\equal{#1}{}}{}{\mbox{\sffamily\color{lightblack}\fontseries{sb}\selectfont\Large #1}\vspace{-2pt}}%
		    #2
		  };
		\coordinate (next left column anchor) at ([yshift=-9mm]last left column block.south west);
	}

	\newcommand{\makeApplicantPicture}{%
		\node[
		  fill=white,
		  anchor=north west,
		  rectangle,
		  line width=\rulewidth,
		  inner sep=2mm,
		  outer sep=0mm,
		  rounded corners
		] (applicant picture) at ([xshift=12mm]leftcol fill.west|-next left column anchor)
		{\includegraphics[width=.2\paperwidth]{\aPicture}};
		\coordinate (next left column anchor) at ([yshift=-9mm]applicant picture.south west);
	}

	\newenvironment{curriculumvitae}
	% on begin
	{
		
		\newgeometry{margin=0pt}
		\fancyhf{} % clear all header and footers
		\ClearShipoutPicture % remove background (header and footer boxes)
		% \lhead{}
		% \rhead{\sffamily\fontseries{el}\selectfont\color{lightblack}\Lpage~\thepage}
		
		\tikzstyle{left cv column default} = [
		  text width=.25\paperwidth,
		  anchor=north west,
		  inner sep=12mm
		]
		
		\tikzstyle{left cv column block} = [
		  left cv column default,
		  inner ysep=6mm
		]

		\begin{tikzpicture}
			\node[
			  left cv column default,
			  text depth=\pdfpageheight-25mm,
			  minimum height=\pdfpageheight,
			  left cv column
			] (leftcol fill) at (current page.north west) {}; % just the fill

			\coordinate (next left column anchor) at ([yshift=-13mm, xshift=12mm]leftcol fill.north west);
			
			% applicant picture (only if set)
			\ifthenelse{\equal{\aPicture}{}}{}{%
				\makeApplicantPicture
	        }

			\leftColumnBlock{%
				{\sffamily\color{lightblack}\fontseries{sb}\selectfont\huge\raggedleft\aName}\par
				{\sffamily\LARGE\aPosition}\par
			}

			\leftColumnBlock[Schl\"usselkompetenzen]{%
				\begin{itemize}[topsep=0pt, itemsep=-9pt, itemindent=-12pt]
					\item Gewebe
					\item Textilien
					\item Muster
				\end{itemize}\par
			}

			\leftColumnBlock[Referenzen]{%
				\begin{itemize}[topsep=0pt, itemsep=-9pt, itemindent=-12pt]
					\item Mutter Theresa
					\item Helmut Kohl
				\end{itemize}\par
			}

			\leftColumnBlock[Sprachen]{%
				\begin{itemize}[topsep=0pt, itemsep=-9pt, itemindent=-12pt]
					\item Deutsch (Muttersprache)
					\item English (Well well)
				\end{itemize}\par
			}

			\leftColumnBlock[Kontakt]{%
				\begin{itemize}[label={}, topsep=0pt, itemsep=-12pt, itemindent=-12pt]
					\item \aStreet
					\item \aCity \\[5mm]
					\item \Telefon\hspace{6pt}\aPhone
				    \item \Letter\hspace{7pt}\href{mailto:\aMail}{\texttt{\aMail}}
				\end{itemize}\par
			}

			% \leftColumnBlock[Sonstiges]{%
			% 	\begin{itemize}[label={}, topsep=0pt, itemsep=-12pt, itemindent=-12pt]
			% 		\item \Lborn~\aBirthday
			% 		\item \Lin~\aBirthplace
			% 	\end{itemize}\par
			% }





			\node[
			  text width=.7\paperwidth,
			  anchor=north west,
			  inner xsep=8mm,
			  inner ysep=12mm
			  % text depth=\pdfpageheight-25mm,
			  % minimum height=\pdfpageheight
			] (cv) at (leftcol fill.north east) {

				foo

				% % \begin{minipage}[t][.99\pdfpageheight]{.74\paperwidth}

				% % curricum vitae
				% \renewcommand*{\cvheadingfont}{\color{lightblack}\fontseries{sb}\selectfont\Large}
				% \renewcommand*{\cvlistheadingfont}{\color{black!98}\fontseries{sb}\selectfont} % not large (which is the default)

				% \setlength{\cvlabelwidth}{32mm}

				% \begin{cvsection}{\Lpersinfo.}	% personal information
				% 	\item \aName\\
				% 	      \aStreet\\
				% 	      \aCity
				% 	\item \Ltelephone: \aPhone\\
				% 	      \Lmail: \href{mailto:\aMail}{\texttt{\aMail}}
				% 	      \ifthenelse{\equal{\aXING}{}}{}{\par\href{https://www.xing.com/profile/\aXING}{\texttt{xing.com/profile/\aXING}}}
				% 	      \ifthenelse{\equal{\aLinkedIn}{}}{}{\par\href{https://www.linkedin.com/in/\aLinkedIn}{\texttt{linkedin.com/in/\aLinkedIn}}}
				% 	      \ifthenelse{\equal{\aGitHub}{}}{}{\\\href{https://github.com/\aGitHub}{\texttt{github.com/\aGitHub}}}
				% 	\ifthenelse{\equal{\aBirthday}{} \OR \equal{\aBirthplace}{}}{}{%
				% 	  \item \Lborn~\aBirthday\, \Lin~\aBirthplace
				% 		\ifthenelse{\equal{\aFamilyStatus}{} \OR \equal{\aNationality}{}}{}{%
				% 	          \\\aFamilyStatus, \aNationality
				% 		}
				% 	}
				% \end{cvsection}


			};
		\end{tikzpicture}

	}
	% on end
	{
	
		\cvplace{\sCity}
		\date{\Lthe~\today}

		% \end{minipage}

		% };
		% \end{tikzpicture}
		\pagebreak
		
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
