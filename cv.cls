%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                           Louis-Kenzo Furuya-Cahier                          %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Identification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2013/01/19 Louis-Kenzo Furuya Cahier's CV class]

%%%%%%%%%%%%%%%%%%%%%%%% External classes and packages %%%%%%%%%%%%%%%%%%%%%%%%%

% Derive the class from the standard article class
\LoadClass[a4paper,12pt,oneside,onecolumn,final]{article}

% Helper packages that don't change the output
\RequirePackage{xkeyval} % Named parameter syntax and options to both the package and in commands
\RequirePackage{ifthen}  % Easier syntax for conditionals

% Other packages
\RequirePackage[paper=a4paper,%
                marginparsep=0.5cm,%
                marginparwidth=2cm,%
                lmargin=2cm,%
                rmargin=2cm,%
                tmargin=2cm,%
                bmargin=4cm,%
                footskip=1.5cm%
                ]{geometry} % 
\RequirePackage{layout}
\RequirePackage{fancyhdr}   % Header and footer customization
%\RequirePackage{titling}
%\RequirePackage[explicit]{titlesec}
\RequirePackage{fontspec}   % Unicode and OpenType font management
\RequirePackage{tabu}       % Improved tabular environment
%\RequirePackage{changepage}
\RequirePackage{enumitem}   % Adjustment of list environments
%\RequirePackage{everypage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Title %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand\maketitle{%
	\begingroup
		\if@twocolumn
			\ifnum \col@number=\@ne
				\@maketitle
			\else
				\twocolumn[\@maketitle]%
			\fi
		\else
			\@maketitle
		\fi
	\endgroup
}

\renewcommand{\@maketitle}[1]{%
	\begin{center}
		\begin{tabu} {@{} X[1,l,b] @{} X[3,c,b] @{} X[1,r,m] @{}}
			{\footnotesize January 21{\addfontfeatures{VerticalPosition=Ordinal}st} 2013}
			& 
			\@titlestyle{\@namestyle{}{Louis-Kenzo} {\addfontfeatures{Letters=SmallCaps} Furuya Cahier}} %
			& 
			{\footnotesize French, Japanese citizen}
		\end{tabu}
		\vskip .1em
		\hrulefill
	\end{center}
	\vskip 1.3em
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Header and footer %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%
	% Set the header and footer now, as this command is called from inside the document environment when meta-data like address etc. has already been set
	\cv@setheaderfooter
}
\newcommand{\cv@setheaderfooter}[0]{%
	\pagestyle{fancy}
	\renewcommand{\headrulewidth}{0.0pt}
	\renewcommand{\footrulewidth}{0.0pt}
	\fancyhead{}
	\fancyfoot{} 
	
	\cfoot{%
		\@footerstyle{%
			{\large \@ornamentstyle{☙\hspace{0.05em}❧}} \\% ☙❦❧ \char"E001 \char"E002
			\vskip 0.8em
			\@addressstyle{\cv@address}\\%
			\@dingbatstyle{☎} \@phonestyle{\cv@phone} \hspace{0.5em} \@dingbatstyle{✉} \@emailstyle{\cv@email}%
		}%
	}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sections %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\cv@sectiontitlewidth}
\newlength{\cv@sectionbodywidth}
\setlength{\cv@sectiontitlewidth}{94pt}
\setlength{\cv@sectionbodywidth}{377pt}

\AtBeginDocument{%
	\begin{tabu} {@{} X[1,l] X[4,l,p] @{}} 
		\null \the\hsize \setlength{\cv@sectiontitlewidth}{\hsize} \the\cv@sectiontitlewidth 
		&
		\null \the\hsize \setlength{\cv@sectionbodywidth}{\hsize} \the\cv@sectionbodywidth 
		\\

		\the\cv@sectiontitlewidth 
		&
		\the\cv@sectionbodywidth 
		\\
	\end{tabu}
	
}

\newsavebox{\cv@sectiontitle}
\newsavebox{\cv@sectionbody}
\newenvironment{component}[1]{
	\begin{lrbox}{\cv@sectiontitle}
		\begin{minipage}[t]{\cv@sectiontitlewidth}
			\@headingstyle{#1}
		\end{minipage}
	\end{lrbox}
	\begin{lrbox}{\cv@sectionbody}
		\begin{minipage}[t]{\cv@sectionbodywidth}
}{%
		\end{minipage}
	\end{lrbox}
	\begin{tabu} {@{} X[1,l] X[4,l,p] @{}} 
		\usebox{\cv@sectiontitle}
		&
		\usebox{\cv@sectionbody}
	\end{tabu}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fonts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\defaultfontfeatures{Mapping=tex-text,%
                     Numbers=OldStyle,%
                     Ligatures={Common},%
                     ItalicFeatures={Ligatures={Common,Historic,Rare},%
                                     Contextuals={WordInitial,WordFinal,LineFinal,Inner}}%
}

\setmainfont []{Adobe Garamond Pro}
\setsansfont []{Linux Biolinum O}
\setmonofont []{Linux Libertine Mono O}

\newfontface \@namefont[Letters=SmallCaps]{EB Garamond 12 Regular}
\newfontface \@dingbatfont[]{DejaVu Sans}
\newfontface \@ornamentfont[CharacterVariant={}]{EB Garamond}

\newcommand \@headerstyle[1]{{#1}}
\newcommand \@titlestyle[1]{{\LARGE#1}}
\newcommand \@footerstyle[1]{{#1}}
\newcommand \@headingstyle[1]{{%
	\fontspec[Contextuals={Swash,WordInitial,WordFinal},%
	          Ligatures={Common,Historical,Rare}%
	         ]{Adobe Garamond Pro}%
	\Large#1%
}}

\newcommand \@namestyle[1]{{\@namefont{#1}}}
\newcommand \@addressstyle[1]{{#1}}
\newcommand \@dingbatstyle[1]{{\@dingbatfont#1}}
\newcommand \@ornamentstyle[1]{{\@ornamentfont#1}}
\newcommand \@phonestyle[1]{{#1}}
\newcommand \@emailstyle[1]{{\fontspec{EB Garamond 12 Regular}#1}}
\newcommand \@datestyle[1]{{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Formatting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\parindent}{0pt}
\setlist[itemize]{noitemsep,%
                  nolistsep,%
                  leftmargin=*,%
                  itemsep=-0.0\baselineskip%
                 }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% User interface %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Commands for formatting educational institutions, companies, addresses, etc.
% Address
\newcommand{\address}[1]{\gdef\cv@address{#1}}

% Phone
\newcommand{\phone}[1]{\gdef\cv@phone{#1}}

% Email
\newcommand{\email}[1]{\gdef\cv@email{#1}}

% Formatting commands
% Emphasis
\newcommand{\emphasis}[1]{{\bfseries #1}}

% 
\newcommand{\country}[1]{{\addfontfeatures{Letters=SmallCaps}\small#1}}

% Position formatting
\newcommand{\cv@position@title}{}
\newcommand{\cv@position@institution}{}
\newcommand{\cv@position@institution@country}{}
\newcommand{\cv@position@from}{}
\newcommand{\cv@position@to}{}
\define@key{positionoptions}{title}[]{%
	\renewcommand{\cv@position@title}{#1}%
}
\define@key{positionoptions}{institution}[]{%
	\renewcommand{\cv@position@institution}{#1}%
}
\define@key{positionoptions}{country}[]{%
	\renewcommand{\cv@position@institution@country}{#1}%
}
\define@key{positionoptions}{from}[]{%
	\renewcommand{\cv@position@from}{#1}%
}
\define@key{positionoptions}{to}[]{%
	\renewcommand{\cv@position@to}{#1}%
}
\newenvironment{position}[1][]%
{% Before
	\setkeys{positionoptions}{#1}%
	\emphasis{\addfontfeatures{} \cv@position@title} \hfill \@datestyle{\cv@position@from–\cv@position@to}\\%
	{\addfontfeatures{} \itshape \cv@position@institution}, \country{\cv@position@institution@country}\\%
}%
{}%After

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
