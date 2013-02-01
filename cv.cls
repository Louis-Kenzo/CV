%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                      CV                                      %
%                           Louis-Kenzo Furuya-Cahier                          %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% TODO Skill strength using varying bullet size

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Identification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2013/01/31 Louis-Kenzo Furuya Cahier's CV class]

%%%%%%%%%%%%%%%%%%%%%%%% External classes and packages %%%%%%%%%%%%%%%%%%%%%%%%%

% Derive the class from the standard article class
\LoadClass[a4paper,12pt,oneside,onecolumn,final]{article}

% Helper packages that don't change the output
\RequirePackage{xkeyval}  % Named parameter syntax and options to both the package and in commands
\RequirePackage{ifthen}   % Easier syntax for conditionals

% Other packages
\RequirePackage[paper=a4paper,
                marginparsep=5mm,
                marginparwidth=20mm,
                lmargin=20mm,
                rmargin=20mm,
                tmargin=15mm,
                bmargin=40mm,
                footskip=15mm
                ]{geometry}         % Customize page geometry, general layout
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

%%%%%%%%%%%%%%%%%%% Meta-information specification commands %%%%%%%%%%%%%%%%%%%%

% Contact address
% USAGE: \address{Building, street, city, province, country, postcode}
\newcommand{\address}[1]{\gdef\cv@contactaddress{#1}}

% Landline phone number
% USAGE: \landline{+123 456 789 012}
\newcommand{\landline}[1]{\gdef\cv@landline{#1}}

% Mobile phone number
% USAGE: \mobile{+456 789 012 345}
\newcommand{\mobile}[1]{\gdef\cv@mobilephone{#1}}

% Email address
% USAGE: \email{john.doe@domain.ext}
\newcommand{\email}[1]{\gdef\cv@email{#1}}

% Name specification
% USAGE: \name{title=Dr., given=John, middle=Peter, family=Doe}
\newcommand{\name}[1]{
	\setkeys{nameoptions}{#1}% Process passed options
}

%%%%%%%%%%%%%%%%%%%% Text semantic signaling and formating %%%%%%%%%%%%%%%%%%%%%

% Mark essential text passages, and potentially highlight them through formatting.
% USAGE: \synopsize{Some text that should be read when skimming through.}
\newcommand{\synopsize}[1]{#1} % TODO Add a switch for \emph{#1}
% Set the style for \synopsize.
% USAGE: \synopsizestyle{\bfseries #1}
\newcommand{\synopsizestyle}[1]{\renewcommand{\cv@synopsizestyle}[1]{#1}}

% Formats its argument as a country name according to the style settable with \countrystyle.
% USAGE: \country{United States of America}
\newcommand{\country}[1]{\cv@countrystyle{#1}}
% Set the style for \country.
% USAGE: \countrystyle{\bfseries #1}
\newcommand{\countrystyle}[1]{\renewcommand{\cv@countrystyle}[1]{#1}}

% Institution
% TODO

% Person
% TODO

% Address
% TODO

% Telephone number
% TODO

%%%%%%%%%%%%%%%%%%%%%%%%%%% Stylistic text formating %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Emphasize text according to the style settable with \emphasisstyle.
% USAGE: \emphasis{Some text to emphasize}
\newcommand{\emphasis}[1]{\cv@emphasisstyle{#1}}

% Set the style for \emphasis
% USAGE: \emphasisstyle{\bfseries #1}
\newcommand{\emphasisstyle}[1]{\renewcommand{\cv@emphasisstyle}[1]{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Header %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Full-width environment without a title on the left.
% USAGE: \begin{header}
%        	\begin{itemize}
%        		\item[•] Did some cool stuff and have many skills.
%        		\item[•] Can also walk on a hand and an arm.
%           \end{itemize}
%        \end{header}
\newenvironment{header}[0]{
	\begin{cv@offsetsectionmargin}
}{
	\end{cv@offsetsectionmargin}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Position specification %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Specified and formats a section describing a position.
% USAGE: \begin{position}[title=Lead developer,
%                         institution=MyCompany,
%                         country=France,
%                         from=2000,
%                         to=2010]
%        	Description of the position
%        \end{position}
\newenvironment{position}[1][]%
{% Before
	\setkeys{positionoptions}{#1}% Process passed options
	\emphasis{\addfontfeatures{} \cv@position@name@title} \hfill \@datestyle{\cv@position@from–\cv@position@to}\\%
	{\addfontfeatures{} \itshape \cv@position@institution}, \country{\cv@position@institution@country}\\%
}%
{}%After

%%%%%%%%%%%%%%%%%%%%%%% Section title gutter dimensions %%%%%%%%%%%%%%%%%%%%%%%%

% Adjusts the width of the section title area.
% USAGE: \sectionwidth{2cm}
\newcommand{\sectionwidth}[1]{%
	\setlength{\cv@sectionwidth}{#1}\cv@updatesectiongeometry%
}

% Adjusts the separator between the section title area and the text body.
% USAGE: \sectionsep{5mm}
\newcommand{\sectionsep}[1]{%
	\setlength{\cv@sectionsep}{#1}\cv@updatesectiongeometry%
}

%%%%%%%%%%%%%%%%%%%%%%% Margin adjustments %%%%%%%%%%%%%%%%%%%%%%%%

% Margin adjustment
% USAGE: \margins{top=-5mm, bottom=-5mm, footskip=-5mm}
\newcommand{\margins}[1]{
	\setkeys{marginsoptions}{#1}% Process passed options
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                   Backend                                    %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Meta-information variables %%%%%%%%%%%%%%%%%%%%%%%%%%

% Title
\newcommand{\cv@name@title}{}
\newcommand{\cv@name@given}{}
\newcommand{\cv@name@middle}{}
\newcommand{\cv@name@family}{}
% Address
\newcommand{\cv@contactaddress}{}
% Landline phone
\newcommand{\cv@landline}{}
% Mobile phone
\newcommand{\cv@mobilephone}{}
% Email
\newcommand{\cv@email}{}

% Name options
\define@key{nameoptions}{title}[]{%
	\renewcommand{\cv@name@title}{#1}%
}
\define@key{nameoptions}{given}[]{%
	\renewcommand{\cv@name@given}{#1}%
}
\define@key{nameoptions}{middle}[]{%
	\renewcommand{\cv@name@middle}{#1}%
}
\define@key{nameoptions}{family}[]{%
	\renewcommand{\cv@name@family}{#1}%
}

%%%%%%%%%%%%%%%%%%%%%%% Margin adjustments %%%%%%%%%%%%%%%%%%%%%%%%

% Margin adjustment options
\define@key{marginsoptions}{top}[]{%
	\geometry{tmargin=\cv@gettopmargin + (#1)}%
}
\define@key{marginsoptions}{bottom}[]{%
	\geometry{bmargin=\cv@getbottommargin + (#1)}%
}
\define@key{marginsoptions}{left}[]{%
	\geometry{lmargin=\cv@getleftmargin + (#1)}%
}
\define@key{marginsoptions}{right}[]{%
	\geometry{rmargin=\cv@getrightmargin + (#1)}%
}
\define@key{marginsoptions}{footskip}[]{%
	\geometry{footskip=\cv@getfootskip + (#1)}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Page geometry %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Section title gutter offset disabling environment.
% Brings the left text margin back to where the section headers start.
\newenvironment{cv@offsetsectionmargin}[0]{%
	\begin{adjustwidth}{-\cv@sectionwidth-\cv@sectionsep}{0mm}%

}{%
	\end{adjustwidth}%
}

% Adjusts the left margin to leave room for the section title gutter.
\newcommand{\cv@updatesectiongeometry}[0]{%
	\geometry{lmargin=20mm+\cv@sectionwidth+\cv@sectionsep}%
}

% Layout calculation tools
\newcommand{\cv@getleftmargin}[0]{%
	((1in + \hoffset) + \oddsidemargin - (\cv@sectionwidth + \cv@sectionsep))
}
\newcommand{\cv@getleftborder}[0]{%
	\cv@getleftmargin
}
\newcommand{\cv@getrightmargin}[0]{%
	(\paperwidth-\cv@getrightborder)
}
\newcommand{\cv@getrightborder}[0]{%
	(\cv@getleftmargin+\cv@sectionwidth+\cv@sectionsep+\textwidth)
}
\newcommand{\cv@gettopmargin}[0]{%
	(1in+\voffset+\topmargin+\headheight+\headsep)%
}
\newcommand{\cv@gettopborder}[0]{%
	\cv@gettopmargin%
}
\newcommand{\cv@getbottommargin}[0]{%
	(\paperheight-\cv@getbottomborder)%
}
\newcommand{\cv@getbottomborder}[0]{%
	(\cv@gettopborder+\textheight)%
}
\newcommand{\cv@getfootskip}[0]{%
	\footskip%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Title %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Outputs the title when \maketitle is called.
\renewcommand\maketitle{%
	% Bring back the margins to the non-section title gutter configuration.
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

% Private helper to output the title, not caring about margins.
\renewcommand{\@maketitle}[1]{%
	\begin{center}
		\begin{tabu} {@{} X[1,l,b] @{} X[10,c,b] @{} X[1,r,m] @{}}
			%{\footnotesize January 21{\addfontfeatures{VerticalPosition=Ordinal}st} 2013}
			& 
			\@name@titlestyle{
			% Given name
			\ifthenelse{\equal{\cv@name@given}{}}{}{ % else
				{%
					\cv@name@given
				}%
			}%
			%
			% Middle name
			\ifthenelse{\equal{\cv@name@middle}{}}{}{ % else
				{%
					\addfontfeatures{Ligatures={Historic,Rare},Contextuals={Swash}} \itshape
					\cv@name@middle
				}%
			}%
			%
			% Family name
			\ifthenelse{\equal{\cv@name@family}{}}{}{ % else
				{%
					\addfontfeatures{Letters=SmallCaps}
					\cv@name@family
				}%
			}%
			}%
			& 
			%{\footnotesize French, Japanese citizen}
		\end{tabu}
		\vskip .1em
		\hrulefill
	\end{center}
	\vskip 1.1em
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Header and footer %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set the header and footer automatically at the beginning of the document, after the preamble.
% This way meta-data like address, name, phone number, etc. used in the footer have already been specified by the user in the preamble.
\AtBeginDocument{%
	\cv@setheaderfooter
}

% Private helper to output the footer proper.
\newcommand{\cv@setheaderfooter}[0]{%
	\pagestyle{fancy}
	\renewcommand{\headrulewidth}{0.0pt}
	\renewcommand{\footrulewidth}{0.0pt}
	\fancyhead{}
	\fancyfoot{} 
	\fancyhfoffset[L]{\cv@sectionwidth + \cv@sectionsep}
	
	\cfoot{%
		\@footerstyle{%
			{\large \@ornamentstyle{☙\hspace{0.05em}❧}} \\% ☙❦❧ \char"E001 \char"E002
			\vskip 0.8em
			%{\@emailstyle{www.louis-kenzo.com}}\\
			\@addressstyle{\cv@contactaddress}\\%
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
\cv@updatesectiongeometry
% Specify the section formatting and spacing
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Position specification %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Variable initialization
\newcommand{\cv@position@name@title}{}
\newcommand{\cv@position@institution}{}
\newcommand{\cv@position@institution@country}{}
\newcommand{\cv@position@from}{}
\newcommand{\cv@position@to}{}

% Call interface options declaration
\define@key{positionoptions}{title}[]{%
	\renewcommand{\cv@position@name@title}{#1}%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fonts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\defaultfontfeatures{Mapping=tex-text,%
                     Numbers=OldStyle,%
                     Ligatures={Common},%
                     ItalicFeatures={Ligatures={Common},% {Common,Historic,Rare}
                                     Contextuals={WordInitial,WordFinal,LineFinal,Inner}}%
}

\setmainfont []{Adobe Garamond Pro}
\setsansfont []{Linux Biolinum O}
\setmonofont []{Linux Libertine Mono O}

\newfontface \@namefont[Letters=SmallCaps]{EB Garamond 12 Regular}
\newfontface \@dingbatfont[]{DejaVu Sans}
\newfontface \@ornamentfont[]{EB Garamond}

\newcommand \@headerstyle[1]{{#1}}
\newcommand \@name@titlestyle[1]{{\LARGE#1}}
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

\newcommand \cv@synopsizestyle[1]{#1}
\newcommand \cv@emphasisstyle[1]{{\bfseries #1}}
\newcommand \cv@countrystyle[1]{{\addfontfeatures{Letters=SmallCaps}\small#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% General Formatting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set new default for the often used itemize environments. Make more compact by removing left margin and separation between bullet paragrpahs.
\setlength{\parindent}{0pt}
\setlist[itemize]{noitemsep,%
                  nolistsep,%
                  leftmargin=*,%
                  itemsep=-0.0\baselineskip%
                 }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
