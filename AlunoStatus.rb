def calcularSituacaoAluno(aluno)
    if aluno.presenca < 0.75
        aluno.situacaoNoSemestre = "reprovado por falta."

    elsif aluno.mediaFinalNoSemestre >= 5
        aluno.situacaoNoSemestre = "aprovado."

    elsif aluno.mediaFinalNoSemestre >= 3
        aluno.situacaoNoSemestre = "recuperação."

    else
        aluno.situacaoNoSemestre = "reprovado por nota."
    end
    
    return aluno
end

def calcularMedia(aluno)
    p1 = aluno.a1 * 0.7 + aluno.ma1 * 0.2 + aluno.mb1 * 0.1
    p2 = aluno.a2 * 0.7 + aluno.ma2 * 0.2 + aluno.mb2 * 0.1
    aluno.mediaFinalNoSemestre = (p1 + 2 * p2) / 3
    return aluno
end

def validarFaltasSemestre(text, aulasDadas)
    while true
        print(text)
        faltas = gets.to_i
        
        if faltas.between?(0, aulasDadas)
            break
        else
            puts "Inválido, a quantidade de faltas não pode ser maior que a quantidade de aulas dadas no semestre ou menor que zero."
        end
    end     
    return faltas
end

def validarAulasDadasSemestre(text)
    while true
        print(text)
        semestre = gets.to_i
        
        if semestre.between?(0, 180)
            break
        else
            puts "Inválido, informe um valor entre 0 e 180."
        end
    end

    return semestre
end

def validarNotas(text)
    while true
        print(text)
        nota = gets.to_f
        
        if nota.between?(0, 10)
            break
        else
            puts "Nota inválida, informe um valor entre 0 e 10."
        end
    end     
    return nota
end

def criarAluno()
    aluno = Aluno.new
    aluno.a1 = validarNotas("A1: ")
    aluno.ma1 = validarNotas("Ma1: ")
    aluno.mb1 = validarNotas("Mb1: ")

    aluno.a2 = validarNotas("A2: ")
    aluno.ma2 = validarNotas("Ma2: ")
    aluno.mb2 = validarNotas("Mb2: ")

    aluno.qtdAulasDadasNoSemestre = validarAulasDadasSemestre("Quantidade de aulas dadas no semestre: ")
    aluno.qtdFaltasNoSemestre = validarFaltasSemestre("Quantidade de faltas no semestre: ", aluno.qtdAulasDadasNoSemestre)
    aluno.presenca = (aluno.qtdAulasDadasNoSemestre - aluno.qtdFaltasNoSemestre).to_f / aluno.qtdAulasDadasNoSemestre.to_f

    return aluno
end

Aluno = Struct.new( :p1, :a1, :ma1, :mb1,
    :p2, :a2, :ma2, :mb2, :qtdAulasDadasNoSemestre,
    :qtdFaltasNoSemestre, :presenca, :mediaFinalNoSemestre,
    :situacaoNoSemestre)

def main()
    puts "Olá, insira abaixo as notas do aluno: "
    aluno = criarAluno()
    aluno = calcularMedia(aluno)
    aluno = calcularSituacaoAluno(aluno)    
    puts "O aluno está #{aluno.situacaoNoSemestre}"

    # Don't close console after script run.
    gets
end

main()