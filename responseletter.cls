%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Response to Reviewers Letter - LaTeX Class File
%
%   Description:
%   This class file provides all the formatting and custom commands for
%   creating a response letter to reviewers.
%
%   Version: 1.0
%   Date: 2025/07/11
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{responseletter}[2025/07/11 v1.0 Response to Reviewers Letter Class]

\def\@revisiontype{Major Revision}
\def\@receiver{Editors and Reviewers}
\def\@metaname{Associate Editors' }

\newif\ifanonymous
\anonymousfalse

\DeclareOption{anonymous}{\anonymoustrue}
\DeclareOption{conference}{%
    \def\@receiver{Reviewers}
    \def\@metaname{Meta-Review's }
}
\DeclareOption{major}{\def\@revisiontype{Major Revision}}
\DeclareOption{minor}{\def\@revisiontype{Minor Revision}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption*{}
\ProcessOptions\relax

\LoadClass[12pt, a4paper]{article}

\RequirePackage[a4paper, margin=2.54cm]{geometry}
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}
\RequirePackage{xcolor}
\RequirePackage{setspace}
\RequirePackage{etoolbox}
\RequirePackage{environ}
\RequirePackage[skip=0.5\baselineskip]{parskip}
\RequirePackage{xparse}
\RequirePackage{ragged2e}
\RequirePackage{listings}

\definecolor{responsecolor}{HTML}{1155cc}

\RequirePackage[
    colorlinks=true,
    linkcolor=responsecolor,
    citecolor=responsecolor,
    urlcolor=responsecolor,
    pdftitle={Response to Reviewers}
]{hyperref}
\RequirePackage{titlesec}

\setstretch{1.15}
\titleformat{\section}{\fontsize{13pt}{15pt}\bfseries}{\thesection}{1em}{}

\AtBeginDocument{%
  \let\oldref\ref
  \renewcommand{\ref}[1]{\textbf{\oldref{#1}}}
  \let\oldcite\cite
  \renewcommand{\cite}[1]{\textbf{\oldcite{#1}}}
  \justifying
}

\newcommand{\manuscriptid}[1]{\def\@manuscriptid{#1}}
\newcommand{\papertitle}[1]{\def\@papertitle{#1}}
\newcommand{\authornames}[1]{\def\@authornames{#1}}
\newcommand{\letterbody}[1]{\def\@letterbody{#1}}
\manuscriptid{N/A}
\papertitle{N/A}
\authornames{The Authors}
\letterbody{%
  Thank you for the constructive reviews and recommendations for improving the manuscript. We have greatly benefited from all the comments and suggestions. Following the comments, we have made \lowercase\expandafter{\@revisiontype}s to our manuscript and summarized our responses below. We are happy to answer any further questions that might arise.

  Thank you very much for your time and kind consideration.
}

\newcommand{\responsesep}{\par\addvspace{2.5ex}\hrule height 0.4pt\par\addvspace{2.5ex}}

\newcounter{metaresponse}
\newcommand{\metareview}{%
  \responsesep
  \section*{Response to \@metaname Comments}%
  \addcontentsline{toc}{section}{Response to \@metaname Comments}%
}
\newcommand{\meta}[2][]{%
  \par\addvspace{\medskipamount}%
  \refstepcounter{metaresponse}%
  \noindent\textbf{Comments:}%
  \ifstrempty{#1}{}{ #1}%
  \par
  \noindent{\color{responsecolor}\textbf{Response:} #2}\par\vspace{1em}
}

\newcounter{reviewer}
\newcounter{comment}[reviewer]
\renewcommand{\thecomment}{R\arabic{reviewer}.C\arabic{comment}}

\NewDocumentCommand{\reviewer}{o}{%
  \responsesep
  \stepcounter{reviewer}%
  \IfNoValueTF{#1}{%
    \section*{Response to Reviewer \#\arabic{reviewer}'s Comments}%
    \addcontentsline{toc}{section}{Response to Reviewer \#\arabic{reviewer}}%
  }{%
    \section*{Response to Reviewer #1's Comments}%
    \addcontentsline{toc}{section}{Response to Reviewer #1}%
  }%
}

\newcommand{\response}[2][]{%
  \par\addvspace{\medskipamount}%
  \refstepcounter{comment}%
  \noindent\textbf{\thecomment:}%
  \ifstrempty{#1}{}{ #1}%
  \par
  \noindent{\color{responsecolor}\textbf{Response:} #2}\par\vspace{1em}
}

\renewcommand{\maketitle}{%
  \begin{center}
    {\fontsize{14pt}{18pt}\selectfont\bfseries
    Response to the Comments Given by the \@receiver\ of \\ Manuscript: \@manuscriptid, \@revisiontype \\[1em]}
    {\mdseries\normalsize
    \textbf{(\@papertitle)}
    \par}
  \end{center}
  \vspace{2em}
  Dear \@receiver,
  
  \@letterbody
  \vspace{2em}
  
  Yours sincerely, \\
  \ifanonymous
      Anonymous Authors
  \else
      \@authornames
  \fi
}

\endinput
