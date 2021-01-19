module TSPSA

using Random

function f(s,D)
    n = size(s,1)
    obj = 0.0
    for i in 1:n
        if i < n
            obj += D[ s[i] , s[i+1] ]
        else
            obj += D[ s[n] , s[1] ]
        end
    end
    return obj
end

function N(s,D)
    sVizinho = deepcopy(s)
    n = size(sVizinho,1)
    i = rand(collect(1:n))
    j = i
    while j == i
        j = rand(collect(1:n))
    end
    temp = sVizinho[i]
    sVizinho[i] = sVizinho[j]
    sVizinho[j] = temp
    return sVizinho
end

function SA(s,D,T,L,α,maxIter)
    sAnterior = s
    foAnterior = f(sAnterior,D)
    sBest = s
    foBest = foAnterior
    for iteracao in 1:maxIter
        for l in 1:L
            sPosterior = N(sAnterior,D)
            foPosterior = f(sPosterior,D)
            Δ = foPosterior - foAnterior
            if Δ < 0
                sAnterior = deepcopy(sPosterior)
                foAnterior = foPosterior
                if  foPosterior < foBest
                    sBest = deepcopy(sPosterior)
                    foBest = foPosterior
                    println("Iteracao: $iteracao l: $l Temp: $T foBest: $foBest sBest: $sBest")
                end
            elseif rand() < ℯ^(-Δ/T)
               sAnterior = deepcopy(sPosterior)
               foAnterior = foPosterior
            end
        end
        T = T * α
        println(">>> Final da Iteracao: $iteracao Temp: $T foBest: $foBest sBest: $sBest")
    end
    return sBest, foBest
end

export SA

end # module
