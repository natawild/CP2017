\documentclass[a4paper]{article}
\usepackage[a4paper,left=3cm,right=2cm,top=2.5cm,bottom=2.5cm]{geometry}
\usepackage{palatino}
\usepackage[colorlinks=true,linkcolor=blue,citecolor=blue]{hyperref}
\usepackage{graphicx}
\usepackage{cp1617t}
%================= lhs2tex=====================================================%
%include polycode.fmt 
%format (div (x)(y)) = x "\div " y
%format succ = "\succ "
%format map = "\map "
%format length = "\length "
%format fst = "\p1"
%format p1  = "\p1"
%format snd = "\p2"
%format p2  = "\p2"
%format Left = "i_1"
%format Right = "i_2"
%format i1 = "i_1"
%format i2 = "i_2"
%format >< = "\times"
%format >|<  = "\bowtie "
%format |-> = "\mapsto"
%format . = "\comp "
%format (kcomp (f)(g)) = f "\kcomp " g
%format -|- = "+"
%format conc = "\mathsf{conc}"
%format summation = "{\sum}"
%format (either (a) (b)) = "\alt{" a "}{" b "}"
%format (frac (a) (b)) = "\frac{" a "}{" b "}"
%format (uncurry f) = "\uncurry{" f "}"
%format (const f) = "\underline{" f "}"
%format TLTree = "\mathsf{TLTree}"
% -- desactivados:
%%format cond p f g = "\mcond{" p "}{" f "}{" g "}"
%format (split (x) (y)) = "\conj{" x "}{" y "}"
%format for f i = "\mathsf{for}\ " f "\ " i
%format B_tree = "\mathsf{B}\mbox{-}\mathsf{tree} "
\def\ana#1{\mathopen{[\!(}#1\mathclose{)\!]}}
%format (cataA (f) (g)) = "\cata{" f "~" g "}_A"
%format (anaA (f) (g)) = "\ana{" f "~" g "}_A"
%format (cataB (f) (g)) = "\cata{" f "~" g "}_B"
%format (anaB (f) (g)) = "\ana{" f "~" g "}_B"
%format Either a b = a "+" b 
%format fmap = "\mathsf{fmap}"
%format NA   = "\textsc{na}"
%format NB   = "\textsc{nb}"
%format inT = "\mathsf{in}"
%format outT = "\mathsf{out}"
%format Null = "1"
%format (Prod (a) (b)) = a >< b
%format fF = "\fun F "
%format e1 = "e_1 "
%format e2 = "e_2 "
%format Dist = "\fun{Dist}"
%format IO = "\fun{IO}"
%format BTree = "\fun{BTree} "
%format LTree = "\mathsf{LTree}"
%format (lcbr (x)(y)) = "\begin{lcbr}" x "\\" y "\end{lcbr}"
%format (longcond (c)(t)(e)) = "\begin{array}{ll}\multicolumn{2}{l}{" c -> "}\\& " t ",\\& " e "\end{array}"
%format cond p f g = "\mcond{" p "}{" f "}{" g "}"
%-------------- interface with pdbc.lhs ------------------------------------
\def\monadification{4.10}
%---------------------------------------------------------------------------

\title{
       	    Cálculo de Programas
\\
       	Trabalho Prático
\\
       	MiEI+LCC --- Ano Lectivo de 2016/17
}

\author{
       	\dium
\\
       	Universidade do Minho
}


\date\mydate

\makeindex

\begin{document}

\maketitle

\begin{center}\large
\begin{tabular}{ll}
\textbf{Grupo} nr. & 37
\\\hline
a67637 & Célia Figueiredo
\\
a67662 & Adriana Pereira
\\
a60993 & Luís Pedro Fonseca 
\end{tabular}
\end{center}

\tableofcontents

\newpage

\section{Preâmbulo}

A disciplina de Cálculo de Programas tem como objectivo principal ensinar
a progra\-mação de computadores como uma disciplina científica. Para isso
parte-se de um repertório de \emph{combinadores} que formam uma álgebra da
programação (conjunto de leis universais e seus corolários) e usam-se esses
combinadores para construir programas \emph{composicionalmente}, isto é,
agregando programas já existentes.
  
Na sequência pedagógica dos planos de estudo dos dois cursos que têm esta
disciplina, restringe-se a aplicação deste método ao desenvolvimento de programas
funcionais na linguagem \Haskell.

O presente trabalho tem por objectivo concretizar na prática os objectivos
da disciplina, colocando os alunos perante problemas de programação que
deverão ser abordados composicionalmente e implementados em \Haskell.
Há ainda um outro objectivo: o de ensinar a documentar programas e
a produzir textos técnico-científicos de qualidade.

\section{Documentação}
Para cumprir de forma integrada os objectivos enunciados acima vamos recorrer
a uma técnica de programa\-ção dita ``\litp{literária}'' \cite{Kn92}, cujo
princípio base é o seguinte:
\begin{quote}\em
Um programa e a sua documentação devem coincidir.
\end{quote}
Por outras palavras, o código fonte e a sua documentação deverão constar
do mesmo documento (ficheiro).

O ficheiro \texttt{cp1617t.pdf} que está a ler é já um exemplo de \litp{programação
literária}: foi gerado a partir do texto fonte \texttt{cp1617t.lhs}\footnote{O
suffixo `lhs' quer dizer \emph{\lhaskell{literate Haskell}}.} que encontrará
no \MaterialPedagogico\ desta disciplina descompactando o ficheiro \texttt{cp1617t.zip}
e executando
\begin{Verbatim}[fontsize=\small]
    lhs2TeX cp1617t.lhs > cp1617t.tex
    pdflatex cp1617t
\end{Verbatim}
em que \texttt\LhsToTeX\ é um pre-processador que faz ``pretty printing''
de código Haskell em \Latex\ e que deve desde já instalar a partir do endereço
\begin{quote}\tt\small
\lhstotex{https://hackage.haskell.org/package/lhs2tex}.
\end{quote}
Por outro lado, o mesmo ficheiro \texttt{cp1617t.lhs} é executável e contém
o ``kit'' básico, escrito em \Haskell, para realizar o trabalho. Basta executar
\begin{Verbatim}[fontsize=\small]
    ghci cp1617t.lhs
\end{Verbatim}
para ver que assim é: 
\begin{quote}
\begin{Verbatim}[fontsize=\small]
GHCi, version 8.0.2: http://www.haskell.org/ghc/  :? for help
[ 1 of 11] Compiling Show             ( Show.hs, interpreted )
[ 2 of 11] Compiling ListUtils        ( ListUtils.hs, interpreted )
[ 3 of 11] Compiling Probability      ( Probability.hs, interpreted )
[ 4 of 11] Compiling Cp               ( Cp.hs, interpreted )
[ 5 of 11] Compiling Nat              ( Nat.hs, interpreted )
[ 6 of 11] Compiling List             ( List.hs, interpreted )
[ 7 of 11] Compiling LTree            ( LTree.hs, interpreted )
[ 8 of 11] Compiling St               ( St.hs, interpreted )
[ 9 of 11] Compiling BTree            ( BTree.hs, interpreted )
[10 of 11] Compiling Exp              ( Exp.hs, interpreted )
[11 of 11] Compiling Main             ( cp1617t.lhs, interpreted )
Ok, modules loaded: BTree, Cp, Exp, LTree, List, ListUtils, Main, Nat,
Probability, Show, St.
\end{Verbatim}
\end{quote}
O facto de o interpretador carregar as bibliotecas do \MaterialPedagogico\ da
disciplina, entre outras, deve-se ao facto de, neste mesmo sítio do texto
fonte, se ter inserido o seguinte código \Haskell:

\begin{code}
import Cp
import List 
import Nat  
import Exp
import BTree
import LTree
import St 
import Probability hiding (cond, choose)
import Data.List
import Test.QuickCheck hiding ((><))
import System.Random  hiding (split)
import GHC.IO.Exception
import System.IO.Unsafe
\end{code}

\noindent Abra o ficheiro \texttt{cp1617t.lhs} no seu editor de texto preferido
e verifique que assim é: todo o texto que se encontra dentro do ambiente
\begin{quote}\small\tt
\verb!\begin{code}!
\\ ... \\
\verb!\end{code}!
\end{quote}
vai ser seleccionado pelo \GHCi\ para ser executado.

\section{Como realizar o trabalho}
Este trabalho teórico-prático deve ser realizado por grupos de três alunos.
Os detalhes da avaliação (datas para submissão do relatório e sua defesa
oral) são os que forem publicados na \cp{página da disciplina} na \emph{internet}.
%
Recomenda-se uma abordagem equilibrada e participativa dos membros do grupo
de trabalho por forma a poderem responder às questões que serão colocadas
na defesa oral do relatório.

Em que consiste, então, o \emph{relatório} a que se refere o parágrafo anterior?
É a edição do texto que está a ser lido, preenchendo o anexo \ref{sec:resolucao}
com as suas respostas. O relatório deverá conter ainda a identificação dos membros
do grupo de trabalho, no local respectivo da folha de rosto.

Para gerar o PDF integral do relatório deve-se ainda correr os comando seguintes,
que actualizam a bibliografia (com \Bibtex) e o índice remissivo (com \Makeindex),
\begin{Verbatim}[fontsize=\small]
    bibtex cp1617t.aux
    makeindex cp1617t.idx
\end{Verbatim}
e recompilar o texto como acima se indicou. Dever-se-á ainda instalar o utilitário
\QuickCheck\ \footnote{Para uma breve introdução ver
e.g.\ \url{https://en.wikipedia.org/wiki/QuickCheck}.}
que ajuda a validar programas em \Haskell.

\section*{Problema 1}

O controlador de um processo físico baseia-se em dezenas de sensores que enviam
as suas leituras para um sistema central, onde é feito o respectivo processamento.

Verificando-se que o sistema central está muito sobrecarregado, surgiu a
ideia de equipar cada sensor com um microcontrolador que faça algum pré-processamento
das leituras antes de as enviar ao sistema central. Esse tratamento envolve
as operações (em vírgula flutuante) de soma, subtracção, multiplicação e divisão. 

Há, contudo, uma dificuldade: o código da divisão não cabe na memória do
microcontrolador, e não se pretende investir em novos microcontroladores
devido à sua elevada quantidade e preço.

Olhando para o código a replicar pelos microcontroladores, alguém verificou que
a divisão só é usada para calcular inversos, |frac 1 x|. Calibrando os sensores foi
possível garantir que os valores a inverter estão entre $1 < x <2$,
podendo-se então recorrer à \taylor{série de Maclaurin}
\begin{eqnarray*}
|frac 1 x| = |summation|_{i=0}^\infty (1-x)^i
\end{eqnarray*}
para calcular |frac 1 x| sem fazer divisões.
Seja então
\begin{quote}
|inv x n| = $|summation|_{i=0}^n(1-x)^i$
\end{quote}
a função que aproxima |frac 1 x| com |n| iterações da série de MacLaurin.
Mostre que |inv x| é um ciclo-for, implementando-o em Haskell (e opcionalmente em C).
Deverá ainda apresentar testes em \QuickCheck\ que verifiquem o funcionamento
da sua solução. (\textbf{Sugestão:} inspire-se no problema semelhante relativo
à função |ns| da secção 3.16 dos apontamentos \cite{Ol05}.)

\section*{Problema 2}
Se digitar \wc{|man wc|} na shell do Unix (Linux) obterá:
\begin{quote}\small
\begin{verbatim}
NAME
     wc -- word, line, character, and byte count

SYNOPSIS
     wc [-clmw] [file ...]

DESCRIPTION
    The wc utility displays the number of lines, words, and bytes contained in
    each input file,  or standard input (if no file is specified) to the stan-
    dard  output.  A line is defined as  a string of characters delimited by a
    <newline> character.  Characters beyond the final <newline> character will
    not be included in the line count.
    (...)
    The following options are available:
    (...)
        -w   The number of words in each input file is written to the standard 
             output.
    (...)
\end{verbatim}
\end{quote}
Se olharmos para o código da função que, em C, implementa esta funcionalidade
\cite{KR78} e nos focarmos apenas na parte que implementa a opção \verb!-w!,
verificamos que a poderíamos escrever, em Haskell, da forma seguinte:
\begin{code}
wc_w :: [Char] -> Int
wc_w []    = 0
wc_w (c:l) =
     if not (sep c) && lookahead_sep l
     then wc_w l + 1
     else wc_w l
       where
          sep c = c `elem` " \r\n\t\v\f\160"
          lookahead_sep []    = True
          lookahead_sep (c:l) = sep c
\end{code}
Re-implemente esta função segundo o modelo \emph{|worker|/|wrapper|} onde
|wrapper| deverá ser um catamorfismos de listas. Apresente os cálculos que
fez para chegar a essa sua versão de |wc_w| e inclua testes em \QuickCheck\
que verifiquem o funcionamento da sua solução. (\textbf{Sugestão:} aplique
a lei de recursividade múltipla às funções |wc_w| e |lookahead_sep|.)

\section*{Problema 3}

Uma ``\btree{B-tree}" é uma generalização das árvores binárias do módulo \BTree\
a mais do que duas sub-árvores por nó:
\begin{code}
data B_tree a = Nil | Block  { leftmost :: B_tree a, block :: [(a, B_tree a)] } deriving (Show,Eq)
\end{code}
Por exemplo, a B-tree\footnote{Créditos: figura extraída de \url{https://en.wikipedia.org/wiki/B-tree}.}
\begin{center}
       \includegraphics[width=0.5\textwidth]{cp1617t_media/B-tree.jpg}
\end{center}
é representada no tipo acima por:
\begin{code}
t = Block {
      leftmost = Block {
                 leftmost = Nil,
                 block = [ (1,Nil),(2,Nil),(5,Nil),(6,Nil)]},
      block = [
               (7,Block {
                          leftmost = Nil,
                          block = [(9,Nil),(12,Nil)]}),
               (16,Block {
                          leftmost = Nil,
                          block = [(18,Nil),(21,Nil)]})
              ]}
\end{code}
Pretende-se, neste problema:
\begin{enumerate}
\item	Construir uma biblioteca para o tipo |B_tree| da forma habitual
        (in + out; ana + cata + hylo; instância na classe |Functor|).
\item
	Definir como um catamorfismo a função |inordB_tree :: B_tree t -> [t]|
        que faça travessias "inorder" de árvores deste tipo.
\item
	Definir como um catamorfismo a função |largestBlock :: B_tree a -> Int|
        que detecta o tamanho do maior bloco da árvore argumento.
\item
	Definir como um anamorfismo a função |mirrorB_tree :: B_tree a -> B_tree a|
        que roda a árvore argumento de 180º
\item
	Adaptar ao tipo |B_tree| o hilomorfismo "quick sort" do módulo |BTree|.
	O respectivo anamorfismo deverá basear-se no gene |lsplitB_tree|
	cujo funcionamento se sugere a seguir:
\begin{quote}
|lsplitB_tree [] = Left ()|
\\
|lsplitB_tree [7] = Right ([],[(7,[])])|
\\
|lsplitB_tree [5,7,1,9] = Right ([1],[(5,[]),(7,[9])])|
\\
|lsplitB_tree [7,5,1,9] = Right ([1],[(5,[]),(7,[9])])|
\end{quote}

\item	A biblioteca \Exp\ permite representar árvores-expressão em formato
        DOT, que pode ser lido por aplicações como por exemplo \Graphviz, produzindo
        as respectivas imagens. Por exemplo, para o caso de árvores \BTree, se definirmos
\begin{code}
dotBTree :: Show a => BTree a -> IO ExitCode
dotBTree = dotpict . bmap nothing (Just . show) . cBTree2Exp
\end{code}
        executando |dotBTree t| para
\begin{quote}\small
|t= Node (6,(Node (3,(Node (2,(Empty,Empty)),Empty)), Node (7,(Empty,Node (9,(Empty,Empty))))))|
\end{quote}
        obter-se-á a imagem
\begin{center}
       \includegraphics[width=0.4\textwidth]{cp1617t_media/dot1.jpg}
\end{center}
        Escreva de forma semelhante uma função |dotB_tree| que permita mostrar em \Graphviz\footnote{Como alternativa a instalar \Graphviz, podem usar \WebGraphviz\ num browser.}
        árvores |B_tree| tal como se ilustra a seguir,
\begin{center}
       \includegraphics[width=0.9\textwidth]{cp1617t_media/dot2.jpg}
\end{center}
        para a árvora dada acima.
\end{enumerate}

\section*{Problema 4}
Nesta disciplina estudaram-se funções mutuamente recursivas e como lidar com elas.
Os tipos indutivos de dados podem, eles próprios, ser mutuamente recursivos.
Um exemplo dessa situação são os chamados \LSystems.

Um \LSystem\ é um conjunto de regras de produção que podem ser usadas para
gerar padrões por re-escrita sucessiva, de acordo com essas mesmas regras.
Tal como numa gramática, há um axioma ou símbolo inicial, de onde se parte
para aplicar as regras. Um exemplo célebre é o do crescimento de algas formalizado
por Lindenmayer\footnote{Ver \url{https://en.wikipedia.org/wiki/Aristid_Lindenmayer}.}
no sistema:
\begin{quote}
\textbf{Variáveis:} |A| e |B|
\\
\textbf{Constantes:} nenhuma
\\
\textbf{Axioma:} |A|
\\
\textbf{Regras:} |A -> A B, B -> A|.
\end{quote}
Quer dizer, em cada iteração do ``crescimento" da alga, cada |A| deriva num par |A B| e
cada |B| converte-se num |A|. Assim, ter-se-á, onde |n| é o número de iterações
desse processo:
\begin{itemize}
\item	|n=0|: |A|
\item	|n=1|: |A B|
\item	|n=2|: |A B A|
\item	|n=3|: |A B A A B|
\item	etc
\end{itemize}

Este \LSystem\ pode codificar-se em Haskell considerando cada variável um
tipo, a que se adiciona um caso de paragem para poder expressar as sucessivas
iterações:
\begin{code}
type Algae = A
data A = NA | A A B deriving Show
data B = NB | B A deriving Show
\end{code}
Observa-se aqui já que |A| e |B| são mutuamente recursivos.
Os isomorfismos |inT|/|outT| são definidos da forma habitual:
\begin{code}
inA :: Either Null (Prod A B) -> A
inA = either (const NA)(uncurry A)

outA :: A -> Either Null (Prod A B)
outA NA = Left ()
outA (A a b) = Right (a,b)

inB :: Either Null A -> B
inB = either (const NB) B

outB :: B -> Either Null A
outB NB = Left ()
outB (B a) = Right a
\end{code}
O functor é, em ambos os casos, |fF X = 1 + X|. Contudo, os catamorfismos
de |A| têm de ser estendidos com mais um gene, de forma a processar também
os |B|,
\begin{code}
cataA :: (Either Null (Prod c d) -> c) -> (Either Null c -> d) -> A -> c
cataA ga gb = ga . (id -|- cataA ga gb >< cataB ga gb) . outA
\end{code}
e a mesma coisa para os |B|s:
\begin{code}
cataB :: (Either Null (Prod c d) -> c) -> (Either Null c -> d) -> B -> d
cataB ga gb = gb . (id -|- cataA ga gb) . outB
\end{code}
Pretende-se, neste problema:
\begin{enumerate}
\item	A definição dos anamorfimos dos tipos |A| e |B|.
\item	A definição da função
\begin{quote}
generateAlgae :: Int -> Algae
\end{quote}
	como anamorfismo de |Algae| e da função
\begin{quote}
showAlgae :: Algae -> String
\end{quote}
	como catamorfismo de |Algae|.
\item	Use \QuickCheck\ para verificar a seguinte propriedade:
\begin{quote}
	|length . showAlgae . generateAlgae = fib . succ|
\end{quote}
\end{enumerate}

\section*{Problema 5}
O ponto de partida deste problema é um conjunto de equipas de futebol, por exemplo:
\begin{code}
equipas :: [Equipa]
equipas = [
   "Arouca","Belenenses","Benfica","Braga","Chaves","Feirense",
   "Guimaraes","Maritimo","Moreirense","Nacional","P.Ferreira",
   "Porto","Rio Ave","Setubal","Sporting","Estoril"
   ]
\end{code}
Assume-se que há uma função |f(e1,e2)| que dá --- baseando-se em informação
acumulada historicamente, e.g.\ estatística --- qual a probabilidade de |e1|
ou |e2| ganharem um jogo entre si.\footnote{Tratando-se de jogos eliminatórios,
não há lugar a empates.} Por exemplo, |f("Arouca","Braga")| poderá dar como
resultado a distribuição
\[
\begin{array}{ll}
Arouca & \rule{05.72mm}{3pt}\ 28.6\%\\
Braga  & \rule{14.20mm}{3pt}\ 71.4\%
\end{array}
\]
indicando que há |71.4%| de probabilidades de |"Braga"| ganhar a |"Arouca"|.

Para lidarmos com probabilidades vamos usar o mónade |Dist a| que vem descrito no apêndice
\ref{sec:Dist} e que está implementado na biblioteca \Probability\ \cite{EK06}
--- ver definição (\ref{eq:Dist}) mais adiante.
A primeira parte do problema consiste em sortear \emph{aleatoriamente} os jogos das equipas.
O resultado deverá ser uma \LTree\ contendo, nas folhas, os jogos da primeira eliminatória
e cujos nós indicam quem joga com quem (vencendo), à medida que a eliminatória prossegue:
\begin{center}
       \includegraphics[width=1.00\textwidth]{cp1617t_media/sorteio.jpg}
\end{center}

A segunda parte do problema consiste em processar essa árvore usando a função
\begin{quote}
|jogo :: (Equipa, Equipa) -> Dist Equipa|
\end{quote}
que foi referida acima. Essa função simula um qualquer jogo, como foi acima
dito, dando o resultado de forma probabilística. Por exemplo, para o sorteio
acima e a função |jogo| que é dada neste enunciado\footnote{Pode, se desejar,
criar a sua própria função |jogo|, mas para efeitos de avaliação terá que ser
usada a que vem dada neste enunciado. Uma versão de |jogo| realista teria que ter
em conta todas as estatísticas de jogos entre as equipas em jogo, etc etc.},
a probabilidade de cada equipa vir a ganhar a competição vem dada na distribuição
seguinte:
\[
\begin{array}{ll}
|Porto| & \rule{36.89mm}{3pt}\ 21.7\%\\
|Sporting| & \rule{36.379999999999995mm}{3pt}\ 21.4\%\\
|Benfica| & \rule{32.3mm}{3pt}\ 19.0\%\\
|Guimaraes| & \rule{15.98mm}{3pt}\ 9.4\%\\
|Braga| & \rule{8.67mm}{3pt}\ 5.1\%\\
|Nacional| & \rule{8.33mm}{3pt}\ 4.9\%\\
|Maritimo| & \rule{6.969999999999999mm}{3pt}\ 4.1\%\\
|Belenenses| & \rule{5.95mm}{3pt}\ 3.5\%\\
|Rio Ave| & \rule{3.9099999999999997mm}{3pt}\ 2.3\%\\
|Moreirense| & \rule{3.23mm}{3pt}\ 1.9\%\\
|P.Ferreira| & \rule{2.38mm}{3pt}\ 1.4\%\\
|Arouca| & \rule{2.38mm}{3pt}\ 1.4\%\\
|Estoril| & \rule{2.38mm}{3pt}\ 1.4\%\\
|Setubal| & \rule{2.38mm}{3pt}\ 1.4\%\\
|Feirense| & \rule{1.19mm}{3pt}\ 0.7\%\\
|Chaves| & \rule{0.68mm}{3pt}\ 0.4\%\\
\end{array}
\]

Assumindo como dada e fixa a função |jogo| acima referida,
juntando as duas partes obteremos um \emph{hilomorfismo} de tipo
|[Equipa] -> Dist Equipa|,
\begin{code}
quem_vence :: [Equipa] -> Dist Equipa
quem_vence = eliminatoria . sorteio
\end{code}
com características especiais: é aleatório no anamorfismo (sorteio) e
probabilístico no catamorfismo (eliminatória).

O anamorfismo |sorteio :: [Equipa] -> LTree Equipa| tem a seguinte arquitectura,
\footnote{A função |envia| não é importante para o processo; apenas se destina
a simplificar a arquitectura monádica da solução.}
\begin{code}
sorteio = anaLTree lsplit . envia . permuta
\end{code}
reutilizando o anamorfismo do algoritmo de ``merge sort'', da biblioteca
\LTree, para construir a árvore de jogos a partir de uma permutação aleatória
das equipas gerada pela função genérica
\begin{quote}
permuta :: [a] -> IO [a]
\end{quote}
A presença do mónade de |IO| tem a ver com a geração de números aleatórios\footnote{Quem
estiver interessado em detalhes deverá consultar
\href{https://hackage.haskell.org/package/random-1.1/docs/System-Random.html}{System.Random}.}.
\begin{enumerate}
\item	Defina a função monádica |permuta| sabendo que tem já disponível
\begin{quote}
|getR :: [a] -> IO (a, [a])|
\end{quote}
|getR x| dá como resultado um par |(h,t)| em que |h| é um elemento de |x| tirado à
sorte e |t| é a lista sem esse elemento -- mas esse par vem encapsulado dentro de |IO|.

\item A segunda parte do exercício consiste em definir a função monádica
\begin{quote}
eliminatoria :: LTree Equipa -> Dist Equipa
\end{quote}
que, assumindo já disponível a função |jogo| acima referida, dá como resultado
a distribuição de equipas vencedoras do campeonato.
\end{enumerate}
\textbf{Sugestão:} inspire-se na secção \monadification\ (\emph{`Monadification'
of Haskell code made easy}) dos apontamentos \cite{Ol05}. 

%----------------- Bibliografia (exige bibtex) --------------------------------%

\bibliographystyle{plain}
\bibliography{cp1617t}

%----------------- Programa, bibliotecas e código auxiliar --------------------%

\newpage

\part*{Anexos}

\appendix

\section{Mónade para probabilidades e estatística}\label{sec:Dist}
%format B = "\mathit B"
%format C = "\mathit C"
Mónades são functores com propriedades adicionais que nos permitem obter
efeitos especiais em progra\-mação. Por exemplo, a biblioteca \Probability\
oferece um mónade para abordar problemas de probabilidades. Nesta biblioteca,
o conceito de distribuição estatística é captado pelo tipo
\begin{eqnarray}
	|newtype Dist a = D {unD :: [(a, ProbRep)]}|
	\label{eq:Dist}
\end{eqnarray}
em que |ProbRep| é um real de |0| a |1|, equivalente a uma escala de |0| a |100%|.

Cada par |(a,p)| numa distribuição |d::Dist a| indica que a probabilidade
de |a| é |p|, devendo ser garantida a propriedade de  que todas as probabilidades
de |d| somam |100%|.
Por exemplo, a seguinte distribuição de classificações por escalões de $A$ a $E$,
\[
\begin{array}{ll}
A & \rule{2mm}{3pt}\ 2\%\\
B & \rule{12mm}{3pt}\ 12\%\\
C & \rule{29mm}{3pt}\ 29\%\\
D & \rule{35mm}{3pt}\ 35\%\\
E & \rule{22mm}{3pt}\ 22\%\\
\end{array}
\]
será representada pela distribuição
\begin{code}
d1 :: Dist Char
d1 = D [('A',0.02),('B',0.12),('C',0.29),('D',0.35),('E',0.22)]
\end{code}
que o \GHCi\ mostrará assim:
\begin{Verbatim}[fontsize=\small]
'D'  35.0%
'C'  29.0%
'E'  22.0%
'B'  12.0%
'A'   2.0%
\end{Verbatim}
É possível definir geradores de distribuições, por exemplo distribuições \emph{uniformes},
\begin{code}
d2 = uniform (words "Uma frase de cinco palavras")
\end{code}
isto é
\begin{Verbatim}[fontsize=\small]
     "Uma"  20.0%
   "cinco"  20.0%
      "de"  20.0%
   "frase"  20.0%
"palavras"  20.0%
\end{Verbatim}
distribuição \emph{normais}, eg.\
\begin{code}
d3 = normal [10..20]
\end{code}
etc.\footnote{Para mais detalhes ver o código fonte de \Probability, que é uma adaptação da
biblioteca \PFP\ (``Probabilistic Functional Programming''). Para quem quiser souber mais
recomenda-se a leitura do artigo \cite{EK06}.}

|Dist| forma um \textbf{mónade} cuja unidade é |return a = D [(a,1)]| e cuja composição de Kleisli
é (simplificando a notação)
\begin{spec}
  ((kcomp f g)) a = [(y,q*p) | (x,p) <- g a, (y,q) <- f x]
\end{spec}
em que |g: A -> Dist B| e |f: B -> Dist C| são funções \textbf{monádicas} que representam
\emph{computações probabilísticas}.

Este mónade é adequado à resolução de problemas de \emph{probabilidades e
estatística} usando programação funcional, de forma elegante e como caso
particular de programação monádica.

\section{Definições auxiliares}\label{sec:helper_functions}
São dadas: a função que simula jogos entre equipas,
\begin{code}
type Equipa = String
 
jogo :: (Equipa, Equipa) -> Dist Equipa
jogo(e1,e2) = D [ (e1,1-r1/(r1+r2)),(e2,1-r2/(r1+r2)) ] where
              r1 = rank e1
              r2 = rank e2
              rank = pap ranks
              ranks = [
                  ("Arouca",5),
                  ("Belenenses",3),
                  ("Benfica",1),
                  ("Braga",2),
                  ("Chaves",5),
                  ("Feirense",5),
                  ("Guimaraes",2),
                  ("Maritimo",3),
                  ("Moreirense",4),
                  ("Nacional",3),
                  ("P.Ferreira",3),
                  ("Porto",1),
                  ("Rio Ave",4),
                  ("Setubal",4),
                  ("Sporting",1),
                  ("Estoril",5)]
\end{code}
a função (monádica) que parte uma lista numa cabeça e cauda \emph{aleatórias},
\begin{code}
getR :: [a] -> IO (a, [a])
getR x = do {
               i <- getStdRandom (randomR (0,length x-1));
               return (x!!i,retira i x)
             } where retira i x = take i x ++ drop (i+1) x
\end{code}
e algumas funções auxiliares de menor importância: uma que ordena
listas com base num atributo (função que induz uma pré-ordem),
\begin{code}
presort :: (Ord a, Ord b) => (b -> a) -> [b] -> [b]
presort f = map snd . sort . (map (fork f id)) 
\end{code}
e outra que converte ``look-up  tables" em funções (parciais):
\begin{code}
pap :: Eq a => [(a, t)] -> a -> t
pap m k = unJust (lookup k m) where unJust (Just a) = a
\end{code}

%----------------- Soluções propostas -----------------------------------------%

\section{Soluções propostas}\label{sec:resolucao}
Os alunos devem colocar neste anexo as suas soluções aos exercícios
propostos, de acordo com o ``layout'' que se fornece. Não podem ser alterados os nomes das funções dadas, mas pode ser adicionado texto e / ou outras funções auxiliares que sejam necessárias.

\subsection*{Problema 1}

\begin{code}
inv :: Double -> Int -> Double
inv x n = snd $ for (invAccum x) (0, 0) n
    where invAccum :: Double -> (Double, Double) -> (Double, Double)
          invAccum x (it, accum) = (it + 1, accum + (1 - x) ** it)

\end{code}


\begin{code}
prop_inv_correctness :: NonNegative Int -> Property
prop_inv_correctness (NonNegative n) = forAll (choose(1, 1.999)) $ \x -> diff n x > tolerance
    where diff :: Int -> Double -> Double
          diff n x = abs $ x - (inv x n)
          tolerance = 0.0001
\end{code}


A sua solução em C pode ser definida da seguinte forma:
\begin{verbatim}
float inv(float x, int n){
    float accum = 0;
    for(int i = 0; i < n; i++){
        accum += pow(1 - x, i);
    }
    return accum;
}
\end{verbatim}



\subsection*{Problema 2}

\begin{code}
wc_w_final :: [Char] -> Int
wc_w_final = wrapper . worker
\end{code}

\begin{code}
wrapper :: (Prod a b) -> b
wrapper = snd

worker :: [Char] -> (Bool, Int)
worker = cataList (either (const (True, 0)) wordAccum)

wordAccum :: (Char, (Bool, Int)) -> (Bool, Int)
wordAccum (a, (b, n))
    | b && (not . sep) a = (sep a, succ n)
    | otherwise = (sep a, n)

sep :: Char -> Bool
sep c = c `elem` " \r\n\t\v\f\160"

\end{code}

\begin{code}
prop_wc_w_correctness1 :: String -> Bool
prop_wc_w_correctness1 str = length (words str) == wc_w_final str

prop_wc_w_correctness2 :: String -> Bool
prop_wc_w_correctness2 str = wc_w str == wc_w_final str

prop_worker_first :: String -> Bool
prop_worker_first [] = True
prop_worker_first str@(c:_) = sep c == (fst (worker str))

\end{code}


Segundo o enunciado pode-se deduzir que:
\begin{eqnarray*}
\start
|lcbr (wc_w.nil = const 0) (wc_w.cons = cond x (succ.wc_w.p2) (wc_w.p2)|
\end{eqnarray*}

, em que:

\begin{eqnarray*}
\start
        | x = uncurry(&&).(split(not.sep.p1)(look.p2)) |
\just={ Absorção-X (11)}
        | x = uncurry(&&).(not.sep >< look).(split(p1)(p2)) |
\just={ Reflexão-X (8)}
        | x = uncurry(&&).(not.sep >< look)|
\end{eqnarray*}


Então temos que:
\begin{eqnarray*}
\start
\just={ Eq- + (27)}
        |wc_w.in = either (const 0) ( cond (uncurry(&&).(not.sep >< look))  (succ.wc_w.p2) (wc_w.p2) ) |
\just={ |look = p1.(split(look)(wc_w))| e |wc_w = p2.(split(look)(wc_w))| }
        |wc_w.in = either (const 0) (longcond (uncurry(&&).(not.sep >< p1.(split(look)(wc_w)))) (succ.p2.(split(look)(wc_w).p2)) (p2.(split(look)(wc_w).p2)) ) |
\just={ Functor- X (14), Natural |p2| (13)}
        |wc_w.in = either (const 0) (longcond (uncurry(&&).(not.sep >< p1).(id >< (split(look)(wc_w)))) (succ.p2.p2.(id >< split(look)(wc_w))) (p2.p2.(id >< split(look)(wc_w)) ) |
\just={ 2ª Lei de Fusão do Condicional (32)}
        |wc_w.in = either (const 0) ((cond     (uncurry(&&).(not.sep >< p1)) (succ.p2.p2) (p2.p2) ).(id >< split(look)(wc_w)) ) |
\just={ Absorção- + (22)}
        |wc_w.in = either (const 0) (cond     (uncurry(&&).(not.sep >< p1)) (succ.p2.p2) (p2.p2) ).(id + (id >< split(look)(wc_w)) ) |
\end{eqnarray*}



Vamos agora trabalhar a expressão de modo a que seja possivel utilizá-la na lei Fokkinga

\begin{eqnarray*}
\start
        |lcbr (look.nil = True) (look.cons = sep c|
\just={ Eq-+ (27), fusão-+(20), Natural-|p1|(12) }
        |look.in = either (True) (sep.p1) |
\just={ Eq- + (27)}
        |look.in = either (True) (sep.p1) |
\just={ Natural-|p1| (12)}
        |look.in = either (True) (p1.(sep >< look)) |
\just={ Natural\_id (1) Absorção- + (22)}
        |look.in = (either (True) (p1)).(id + (sep >< look)) |
\just={ |look = p1.(split(look)(wc_w))|}
        |look.in = (either (True) (p1)).(id + (sep >< p1.(split(look)(wc_w)))) |
\just={ Natural\_id (1), Functor-x (14)}
        |look.in = (either (True) (p1)).(id + (sep >< p1).(id >< (split(look)(wc_w)))) |
\just={ Functor-+ (25)}
        |look.in = (either (True) (p1)).(id + (sep >< p1)).(id + (id >< (split(look)(wc_w)))) |
\just={ Absorção-+ (22)}
        |look.in = (either (True) (p1.(sep >< p1)) ).(id + (id >< (split(look)(wc_w)))) |
\just={ Natural-|p1| (12) }
        |look.in = (either (True) (sep.p1)).(id + (id >< p1.(split(look)(wc_w)))) |
\end{eqnarray*}




Podemos concluir que wordAccum poderá ser representada da seguinte maneira: 
\begin{eqnarray*}
wordAccum = |(split (sep.p1) (cond ((uncurry(&&)).((not.sep)><p1)) (succ.p2.p2) (p2.p2)))|
\end{eqnarray*}



Portanto:
\begin{eqnarray*}
\start
        |lcbr (look.in = (either (True) (sep.p1)).(id + (id >< split(look)(wc_w) ))) (wc_w.in = (either (const 0) ( (uncurry(&&).(not.sep >< p1)) ) -> succ.p2.p2, p2.p2).(id + (id >< split(look)(wc_w)) ))|
\just={ Fokkinga (50)}
        |split(look)(wc_w) = cataList( split (either (True) (sep.p1))  ( either (const 0) (uncurry(&&).(not.sep >< p1) -> succ.p2.p2, p2.p2) )|
\just={ Lei da Troca (28)}
        |split(look)(wc_w) = cataList(either( split (True)(const 0) ) ( split (sep.p1) (uncurry(&&).(not.sep >< p1) -> succ.p2.p2, p2.p2) ) ) |
\just={Def-split(78), def de wordAccum}
        |split(look)(wc_w) = cataList (either (const (True, 0)) wordAccum)|
\just={trivial}
\end{eqnarray*}



\subsection*{Problema 3}

Para gerar o gráfico basta correr este comando: 
dot -Tpng digraphG.dot -o diagrama.png

\begin{code}

inB_tree :: Either () (B_tree a, [(a, B_tree a)]) -> (B_tree a)
inB_tree = either (const Nil) joinB_trees

joinB_trees :: (B_tree a, [(a, B_tree a)]) -> B_tree a
joinB_trees (t1, ts) = Block { leftmost = t1, block = ts}

\end{code}

Uma versão alternativa seria: 

\begin{verbatim}
inB_tree :: Either () (B_tree a, [(a, B_tree a)]) -> B_tree a
inB_tree = either (const Nil) (uncurry Block)
\end{verbatim}

\begin{code}
outB_tree :: B_tree a -> Either () (B_tree a, [(a, B_tree a)])
outB_tree Nil = i1 ()
outB_tree (Block left block) = i2 (left, block) 
\end{code}


\begin{code}
recB_tree :: (b -> d) -> Either z (b, [(a, b)]) -> Either z (d, [(a, d)])
recB_tree f = id -|- (f >< (map (id >< f)))
\end{code}

\begin{code}
baseB_tree :: (a1 -> b1) -> (a -> d) -> Either b (a, [(a1, a)]) -> Either b (d, [(b1, d)])
baseB_tree g f = id -|- (f >< (map (g >< f)))
\end{code}

\begin{code}
cataB_tree :: (Either () (d, [(a, d)]) -> d) -> B_tree a -> d
cataB_tree g = g . (recB_tree (cataB_tree g)) . outB_tree

anaB_tree :: (b -> Either () (b, [(a, b)])) -> b -> B_tree a
anaB_tree g = inB_tree . (recB_tree (anaB_tree g)) . g

hyloB_tree :: (Either () (c, [(a, c)]) -> c) -> (b -> Either () (b, [(a, b)])) -> b -> c
hyloB_tree f g = cataB_tree f . anaB_tree g
\end{code}


\begin{code}

instance Functor B_tree
         where fmap f = cataB_tree ( inB_tree . baseB_tree f id)

\end{code}

\begin{code}

-- esq meio dir
inordB_tree :: B_tree t -> [t]
inordB_tree = cataB_tree inorder_g
    
inorder_g :: Either () ([a], [(a, [a])]) -> [a]
inorder_g = either (const []) join
    where join :: ([a], [(a, [a])]) -> [a]
          join (xs, ys) = xs ++ concat (map (\(n, zs) -> (n:zs)) ys)

\end{code}


\begin{code}
largestBlock :: B_tree t -> Int
largestBlock = cataB_tree (either (const 0) size)
  where size :: (Int, [(a, Int)]) -> Int
        size (x, ys) = max x (length ys)
\end{code}

\begin{code}
mirrorB_tree :: B_tree a -> B_tree a
mirrorB_tree = cataB_tree (inB_tree . (id -|- (id >< reverse)))
\end{code}

\begin{code}
dotB_tree :: Show a => B_tree a -> IO ExitCode
dotB_tree = dotpict . bmap nothing (Just . show) . cB_tree2Exp

cB_tree2Exp :: B_tree a -> Exp [Char] [a]
cB_tree2Exp = cataB_tree (either (const (Var "nil")) connect)

connect :: (Exp v [a], [(a, Exp v [a])]) -> Exp v [a]
connect (x, xs) = Term fsts (x : snds)
    where (fsts, snds) = unzip xs
\end{code}


\begin{code}
qSortB_tree :: Ord a => [a] -> [a]
qSortB_tree = hyloB_tree inorder_g lsplitB_tree

lsplitB_tree :: Ord a => [a] -> Either () ([a], [(a, [a])])
lsplitB_tree []  = i1 ()
lsplitB_tree (x:xs) = i2 (l1, [(x, l2)])
    where (l1, l2) = partB_tree (< x) xs

partB_tree :: (a -> Bool) -> [a] -> ([a], [a])
partB_tree = partition
\end{code}

Mostramos de seguida como proceder à definição da árvore: 

Seguido do comando para a geração do ficheiro .dot: 
\begin{quote}
dotB\_tree t 
\end{quote}

Para a obtenção da imagem é necessário correr o seguinte comando: 
\begin{quote}
dot -Tpng digraphG.dot -o diagrama.png
\end{quote}


\begin{center}
       \includegraphics[width=0.7\textwidth]{diagrama.png}
\end{center}

\subsection*{Problema 4}

\begin{code}
anaA :: (a -> Either Null (a, b)) -> (b -> Either Null a) -> a -> A
anaA ga gb = inA . (id -|- anaA ga gb >< anaB ga gb) . ga

anaB :: (a -> Either Null (a, b)) -> (b -> Either Null a) -> b -> B
anaB ga gb = inB . (id -|- anaA ga gb) . gb

\end{code}


\begin{code}
generateAlgae :: Int -> Algae
generateAlgae = anaA ga gb
    where ga :: Int -> Either Null (Prod Int Int)
          ga 0 = i1 ()
          ga n = i2 (pred n, pred n)
          gb :: Int -> Either Null Int
          gb 0 = i1 ()
          gb n = i2 (pred n)

showAlgae :: Algae -> String
showAlgae = cataA ga gb
    where ga :: Either a (String, String) -> String
          ga = either (const "A") (uncurry (++))
          gb :: Either a String -> String
          gb = either (const "B") id
\end{code}

\begin{code}
prop_algae :: Property
prop_algae = forAll (elements [0..25]) $ \n -> (length . showAlgae . generateAlgae) n == (fromIntegral ((fib . succ) (fromIntegral n)))
\end{code}

\subsection*{Problema 5}

\begin{code}
permuta :: [a] -> IO [a]
permuta [] = return []
permuta input = do 
                (x, xs) <- getR input
                permuted <- permuta xs
                return (x : permuted)
\end{code}

\begin{code}
eliminatoria :: LTree Equipa -> Dist Equipa
eliminatoria = cataLTree g
    where g :: Either Equipa (Dist Equipa, Dist Equipa) -> Dist Equipa
          g = either return distJogo
          distJogo  :: (Dist Equipa, Dist Equipa) -> Dist Equipa
          distJogo (de1, de2) = do
                                e1 <- de1
                                e2 <- de2
                                jogo (e1, e2)  




\end{code}

%----------------- Fim do anexo cpm soluções propostas ------------------------%

%----------------- Índice remissivo (exige makeindex) -------------------------%

\printindex

%----------------- Fim do documento -------------------------------------------%

% Hide here code that is not relevant to the essence of the problems given
\def\hiddencode{
\begin{code}
type Null   = ()
type Prod a b = (a,b)
fork = Cp.split
envia = unsafePerformIO
\end{code}
}

\end{document}

