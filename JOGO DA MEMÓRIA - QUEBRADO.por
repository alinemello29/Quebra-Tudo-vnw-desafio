programa {
  inclua biblioteca Util --> u
  inclua biblioteca Texto --> tx

  cadeia listaDePalavras[] = {
    "Python", "Java", "C++", "JavaScript", "CSharp", "PHP", 
    "GoLang", "Ruby", "Swift", "Rust", "Kotlin", "Perl", 
    "Scala", "SQL", "HTML", "CSS"
  }
  cadeia palavrasEmbaralhadas[9]

  funcao inicio() {
	  telaDeInicio()  
	}

  funcao telaDeInicio() {
    cadeia txt
    logico resposta = falso, jogar = falso
    inteiro nivel 
    
    faca {
      escreva("Bem-vindo ao Jogo da Memória!\n")
      escreva("Pressione 'ENTER' para começar ou 'S' para sair...\n")
      leia(txt)
          
      escolha(tx.caixa_baixa(txt)){
        caso "s":
          resposta = verdadeiro
          jogar = falso
          pare
        caso "":
          resposta = verdadeiro
          jogar = verdadeiro
          pare
        caso contrario:
          escreva("Opção inválida!")
          u.aguarde(1500)
          limpa()
      }
    } enquanto (resposta == falso)

    limpa()

    se (jogar == falso){       
      escreva("Eu sabia que você iria desistir antes mesmo de começar. Volte quando estiver mais capacitado!")
      retorne
    }

    nivel = escolhaNivel()
    loading(nivel)
  }
  
  funcao escolhaNivel() {
    inteiro nivel
    cadeia opcao

    faca {
    escreva(" _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _\n")
    escreva("|   Escolha o nível de dificuldade    |\n")
    escreva("| 1 = Fácil | 2 = Médio | 3 = Dificil |\n")
    escreva("               Nível: ")
    leia(opcao)
      
    escolha (opcao)
    {
      caso "1": 
        nivel = 1
        opcao = "0"         
        pare
      caso "2": 
        nivel = 2
        opcao = "0"
        pare
      caso "3": 
        nivel = 3  
        opcao = "0"        
        pare
      caso contrario:
        escreva("Opção Inválida")
        u.aguarde(1500)
        limpa()		
      }
    } enquanto (opcao != "0")
    
    retorne nivel
  }

  funcao loading(inteiro nivel) {
  	palavrasEmbaralhadas = embaralhePalavras(listaDePalavras)
    	
    limpa()
    escreva("Embaralhando as palavrinhas...\n") 
    escreva("####################\n")

    para (inteiro contador = 4; contador >= 0; contador--) {
      escreva(">>>>")   
      u.aguarde(1000)
    }

    limpa()
    jogo(nivel)  
  }

  funcao embaralhePalavras(cadeia palavras[]) {
    inteiro sorteiaPosicoesPalavras[9] 
    
    sorteiaPosicoesPalavras = sorteioDeNumerosSemRepeticao(15)

    para (inteiro i = 0; i < 9; i++) {      
      palavrasEmbaralhadas[i] = palavras[sorteiaPosicoesPalavras[i]]       
    }

    retorne palavrasEmbaralhadas
  }

  funcao memorize(cadeia palavras[]) {
    escrevePalavra(0, 1, 2, palavras[0], palavras[1], palavras[2])
    escrevePalavra(3, 4, 5, palavras[3], palavras[4], palavras[5])
    escrevePalavra(6, 7, 8, palavras[6], palavras[7], palavras[8])
  }

  funcao jogo(inteiro nivel) {
    cadeia tabuleiroVazio[9] = {"*****", "*****", "*****", "*****", "*****", "*****", "*****", "*****", "*****"}
    inteiro erros, tentativas, acertos, tempo = 0, x = 0, posicao[9], contaErros = 0, contaTentativas = 0
    cadeia respostaPalavra

    escolha(nivel) {
      caso 1:
        erros = 18
        tentativas = 26
        acertos = 0
        tempo = 27
        pare
      caso 2:
        erros = 9
        tentativas = 16
        acertos = 0
        tempo = 18
        pare
      caso 3:
        erros = 5
        tentativas = 14
        acertos = 0
        tempo = 9
        pare
      caso contrario:
        escreva("Opção inválida!")
        u.aguarde(1500)
    } 

    memorizePalavras(tempo)

    posicao = sorteioDeNumerosSemRepeticao(8)

    faca {
      escreva("Erros disponíveis: ", erros)
      escreva(" | Tentativas disponíveis: ", tentativas)
      escreva(" | Acertos: ", acertos)

      memorize(tabuleiroVazio)

      cadeia resposta
      escreva("\n Digite a palavra na posição ", posicao[x], "? ")
      leia(resposta)
      limpa()

      se (tx.caixa_baixa(resposta) == tx.caixa_baixa(palavrasEmbaralhadas[posicao[x]])) {
        acertos++
        tentativas--
        contaTentativas++
        tabuleiroVazio[posicao[x]] = palavrasEmbaralhadas[posicao[x]]
        x++
      } senao {
        erros--
        tentativas--
        contaErros++
        contaTentativas++
      }

      se(acertos == 9){          
        pare
      }
    } enquanto (erros != 0)

    resultado(erros, contaTentativas, acertos, contaErros)
  }

  funcao sorteioDeNumerosSemRepeticao(inteiro limit) {
    inteiro numeros[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
    inteiro sorteio[9], i = 0 

    faca {
      inteiro pos = 0
      inteiro num = numeros[u.sorteia(0, limit)]

      enquanto((pos < 8) e (sorteio[pos] != num)) {
        pos++    
      }

      se(sorteio[pos] != num) {
        sorteio[i] = num   
        i++   
      }
    } enquanto (i < 9)

    retorne sorteio
  }
    
  funcao resultado(inteiro erros, inteiro tentativas, inteiro acertos, inteiro contaErros) {
    se(erros == 0){
      escreva("G4M3R 0V3R!!\n")
      escreva("Número de acertos: ", acertos, " - Número de erros: ", contaErros, " - Número de Tentativas: ", tentativas, "\n")
      u.aguarde(5000)
      limpa()
      inicio()
      retorne
    } 

    escreva("Parabéns! Você ganhou!!\n")
    escreva("Número de acertos: ", acertos, " - Número de erros: ", contaErros, " - Número de Tentativas: ", tentativas, "\n")
    u.aguarde(5000)
    limpa()
    inicio()
  }

  funcao escrevePalavra(inteiro nCarta1, inteiro nCarta2, inteiro nCarta3, cadeia carta1, cadeia carta2, cadeia carta3) {
    escreva("\n        " + nCarta1 + "                 " + nCarta2 + "                 " + nCarta3 + "\n")
    escreva(tx.preencher_a_esquerda('=', 58, "=") + "\n")
    escreva("|     " + tx.preencher_a_esquerda(' ', 10, carta1))
    escreva("   |     " + tx.preencher_a_esquerda(' ', 10, carta2) + "   |     ")
    escreva(tx.preencher_a_esquerda(' ', 10, carta3) + "   |\n")
    escreva(tx.preencher_a_esquerda('=', 58, "="))
  } 

  funcao memorizePalavras(inteiro tempo) {
    memorize(palavrasEmbaralhadas)
    escreva("\n\nTempo para memorizar a palavra: ")
    
    para (inteiro contador = tempo; contador >= 0; contador--) {
      escreva(" #", contador)
      u.aguarde(1000)
    }

    limpa()
  }
}
