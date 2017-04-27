% 
% Alpication
% Copyright 2014, 2017 Mirko Bunse
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
\ProvidesClass{alpication}[2017/04/25 Alpication]

\newwrite\apxList % temporary file for appendix list

%
% dependencies
%
	\LoadClass[a4paper, 11pt]{article}

	\RequirePackage[left=30mm,right=25mm,top=30mm,bottom=40mm]{geometry}
	\RequirePackage{currvita}
	\RequirePackage{ifthen}
	\RequirePackage{wrapfig}
	\RequirePackage{graphicx}
	\RequirePackage{fancyhdr}
	\RequirePackage{eso-pic}
	\RequirePackage[hidelinks]{hyperref}
	\RequirePackage{pdfpages}
	\RequirePackage{enumitem}

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
	
	\newcommand{\applicantName}[1]{\newcommand{\aName}{#1}}
	\newcommand{\applicantStreet}[1]{\newcommand{\aStreet}{#1}}
	\newcommand{\applicantCity}[1]{\newcommand{\aCity}{#1}}
	\newcommand{\applicantPhone}[1]{\newcommand{\aPhone}{#1}}
	\newcommand{\applicantMail}[1]{\newcommand{\aMail}{#1}}
	\newcommand{\applicantXING}[1]{\renewcommand{\aXING}{#1}}
	
	\newcommand{\applicantPicture}[1]{\renewcommand{\aPicture}{#1}}
	\newcommand{\applicantSign}[1]{\renewcommand{\aSign}{#1}}
	\newcommand{\signCity}[1]{\newcommand{\sCity}{#1}}
	
	\newcommand{\applicantBirthday}[1]{\newcommand{\aBirthday}{#1}}
	\newcommand{\applicantBirthplace}[1]{\newcommand{\aBirthplace}{#1}}
	\newcommand{\applicantFamilyStatus}[1]{\newcommand{\aFamilyStatus}{#1}}
	\newcommand{\applicantNationality}[1]{\newcommand{\aNationality}{#1}}
	
	\newcommand{\toAddress}[1]{\renewcommand{\toAddr}{#1}}
	
%
% beginning and end of document
%
	\AtBeginDocument{
		
		% open appendix list writer
		\openout\apxList=\jobname.apx	% not opening immediately allows to input the file to produce a list
		\write\apxList{\textbf{\Lappendix:}}
		\write\apxList{\string\begin{itemize}[nosep]}
		
		% parskip and -indent
		\setlength{\parskip}{8pt}
		\setlength{\parindent}{0pt}
		
		% pagestyle, head and foot
		\pagestyle{fancy}

		\renewcommand{\headheight}{22.0pt}
		\renewcommand{\headrulewidth}{0.4pt}

		\lhead{}
		\rhead{\LARGE \scshape \aName}

		\renewcommand{\footrulewidth}{0.4pt}

		\lfoot{\small\sffamily\aName}
		\cfoot{\small\sffamily\aStreet~\\\aCity}
		\rfoot{\small\sffamily\aPhone~\\\href{mailto:\aMail}{\texttt{\aMail}}}
		
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
			\underline{\footnotesize\sffamily\aName, \aStreet, \aCity}	% applicant address
			
			{\large\sffamily\toAddr}		% addressees address
		}
	
		\vspace{8mm}

		\begin{flushright}		% the date
			\today
		\end{flushright}
	
		\vspace{0mm}
		
		% the correspondence
	
		\textbf{\large\sffamily#1}		% the subject

		\vspace{8mm}
		
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
		
		\lhead{\Lpage~\thepage}
		
		\textbf{\Large\sffamily\Lmotivation}
		
		\vspace{8mm}
		
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
	}
	% on end
	{
		\end{cvlist}
	}

%
% main curriculum vitae environment
%
	\newenvironment{curriculumvitae}
	% on begin
	{
		
		\lhead{\Lpage~\thepage}
		
		\ifthenelse{\equal{\aPicture}{}}{}
		{ % only print picture, if actually defined
		\begin{wrapfigure}[0]{r}{40mm}
			\fbox{
			    \includegraphics[width=35mm]{\aPicture}
			}
		\end{wrapfigure}
		}
		
		% curricum vitae
		
		\begin{cv}{\Lcurrvitae}
		
		\setlength{\cvlabelwidth}{32mm}
	
			\begin{cvsection}{\Lpersinfo}	% personal information
				\item \aName\\
				      \aStreet\\
				      \aCity
				\item \Ltelephone: \aPhone\\
				      \Lmail: \href{mailto:\aMail}{\texttt{\aMail}}
				      \ifthenelse{\equal{\aXING}{}}{}{\\\href{https://www.xing.com/profile/\aXING}{\texttt{xing.com/profile/\aXING}}}
				\item \Lborn~\aBirthday\, \Lin~\aBirthplace\\
				      \aFamilyStatus, \aNationality
			\end{cvsection}
	}
	% on end
	{
	
		\cvplace{\sCity}
		\date{\Lthe~\today}
		
		\end{cv}
		\pagebreak
		
	}

% 
% appendix commands with automatic list
% 
	\newcommand{\apxFolder}{.}
	\newcommand{\appendixFolder}[1]{\renewcommand{\apxFolder}{#1}}
	
	\newcommand{\append}[2]{%
	  \immediate\write\apxList{\noexpand\item #1} % append name to file
	  \includepdf[pages=-]{\apxFolder/#2}
	}
	
	% read appendix list from file if it exists. Otherwise, emit a warning.
	\newcommand{\appendixList}{\IfFileExists{\jobname.apx}{%
	  \vspace*{8mm}
	  \input\jobname.apx
	}{%
	  \ClassWarning{alpication}{File \jobname.apx is missing. Re-run to get references right.}
	}}
