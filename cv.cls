%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                           Louis-Kenzo Furuya-Cahier                          %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% TODO Skill strength using varying bullet size

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
                marginparsep=5mm,%
                marginparwidth=20mm,%
                lmargin=20mm,%
                rmargin=20mm,%
                tmargin=15mm,%
                bmargin=40mm,%
                footskip=15mm%
                ]{geometry} % 
\RequirePackage{layout}
\RequirePackage{fancyhdr}           % Header and footer customization
\RequirePackage[explicit]{titlesec} % Customization of section headers
\RequirePackage{fontspec}           % Unicode and OpenType font management
\RequirePackage{tabu}               % Improved tabular environment
\RequirePackage{changepage}         % On-the-fly adjustment of margins
\RequirePackage{enumitem}           % Adjustment of list environments
\RequirePackage{calc}               % Length calculation
\RequirePackage{marvosym}           % Phone symbols

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                User interface                                %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Commands for formatting educational institutions, companies, addresses, etc.
% Address
\newcommand{\cv@address}{\null}
\newcommand{\address}[1]{\gdef\cv@address{#1}}

% Phone
\newcommand{\cv@landline}{\null}
\newcommand{\landline}[1]{\gdef\cv@landline{#1}}
\newcommand{\cv@mobilephone}{\null}
\newcommand{\mobilephone}[1]{\gdef\cv@mobilephone{#1}}

% Email
\newcommand{\cv@email}{\null}
\newcommand{\email}[1]{\gdef\cv@email{#1}}

% Formatting commands
% Emphasis
\newcommand{\emphasis}[1]{{\bfseries #1}}

% Synopsize
\newcommand{\synopsize}[1]{\emph{#1}}

% 
\newcommand{\country}[1]{{\addfontfeatures{Letters=SmallCaps}\small#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Position specification %%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Header %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{header}[0]{
	\begin{cv@offsetsectionmargin}
}{
	\end{cv@offsetsectionmargin}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                   Backend                                    %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Page geometry %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{cv@offsetsectionmargin}[0]{%
	\begin{adjustwidth}{-\cv@sectionwidth-\cv@sectionsep}{0mm}%

}{%
	\end{adjustwidth}%
}

\newcommand{\cv@updategeometry}[0]{%
	\geometry{lmargin=20mm+\cv@sectionwidth+\cv@sectionsep}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Title %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand\maketitle{%
	\begin{cv@offsetsectionmargin}
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
	\end{cv@offsetsectionmargin}
}

\renewcommand{\@maketitle}[1]{%
	\begin{center}
		\begin{tabu} {@{} X[1,l,b] @{} X[3,c,b] @{} X[1,r,m] @{}}
			%{\footnotesize January 21{\addfontfeatures{VerticalPosition=Ordinal}st} 2013}
			& 
			\@titlestyle{\@namestyle{}{Louis-Kenzo} {\addfontfeatures{Letters=SmallCaps} Furuya Cahier}} %
			& 
			%{\footnotesize French, Japanese citizen}
		\end{tabu}
		\vskip .1em
		\hrulefill
	\end{center}
	\vskip 1.1em
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
	\fancyhfoffset[L]{ ( \cv@sectionwidth + \cv@sectionsep)/2 }
	\fancyhfoffset[R]{ (-\cv@sectionwidth - \cv@sectionsep)/2 }
	
	\cfoot{%
		\@footerstyle{%
			{\large \@ornamentstyle{☙\hspace{0.05em}❧}} \\% ☙❦❧ \char"E001 \char"E002
			\vskip 0.8em
			%{\@emailstyle{www.louis-kenzo.com}}\\
			\@addressstyle{\cv@address}\\%
			\Mobilefone \hspace{0.1em} \@phonestyle{\cv@mobilephone} 
			\hspace{0.4em} 
			{\raise-.30ex\hbox{\large\@dingbatstyle{✉}}} \@emailstyle{\cv@email}
			\hspace{0.4em}
			{\raise-.25ex\hbox{\@dingbatstyle{☎}}} \@phonestyle{\cv@landline}%
		}%
	}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sections %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% User settable settings for
\newlength{\cv@sectionwidth}
\newlength{\cv@sectionsep}
% Set defaults for the section dimensions, and set up the margins with them
\setlength{\cv@sectionwidth}{25mm}
\setlength{\cv@sectionsep}{10mm}
\cv@updategeometry

\newcommand{\sectionwidth}[1]{%
	\setlength{\cv@sectionwidth}{#1}\cv@updategeometry%
}
\newcommand{\sectionsep}[1]{%
	\setlength{\cv@sectionsep}{#1}\cv@updategeometry%
}

\newenvironment{component}[1]%
{
	% Save the current margins 
	\addtolength{\oddsidemargin}{\cv@sectionwidth+\cv@sectionsep}
	\addtolength{\hsize}{-\cv@sectionwidth-\cv@sectionsep}

	% Offset the margins so that section titles printed in the margin by titlesec are properly aligned and in view
	% TODO

	% Print the section heading and setup for the section body
	\section{#1}
}{
	% Now the section has been printed, let's reset the margins to what they were before
	% TODO
	\restoregeometry
}

\titleformat{\section}           % 
            [leftmargin]         % 
            {\null}              % Section formating
            {}                   % Section label
            {0mm}                % Separator before
            {\@headingstyle{#1}} % Section title
            []                   % After

\titlespacing{\section}          % 
             {\cv@sectionwidth}  % Section width
             {-0.2\baselineskip} % Vertical space before title
             {\cv@sectionsep}    % Horizontal separation with text

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
\newfontface \@ornamentfont[]{EB Garamond}

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
\newcommand \@emailstyle[1]{{#1}}
\newcommand \@datestyle[1]{{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Formatting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\parindent}{0pt}
\setlist[itemize]{noitemsep,%
                  nolistsep,%
                  leftmargin=*,%
                  itemsep=-0.0\baselineskip%
                 }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
