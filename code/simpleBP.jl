using StatsBase

# parameters and distributions
offspringdist = weights([.1 .75 .1 .05])

# initialize matrix for results
population = zeros(Int,30,20)
population[1,:].=1

for s in 1:size(population)[2]
	for k in 1:(size(population)[1]-1) 
		population[k+1,s] = sum(sample(collect(0:length(offspringdist)-1),offspringdist ,population[k,s];replace=true))
	end
end

