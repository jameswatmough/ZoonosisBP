using StatsBase

# parameters and distributions
offspringdist = weights([.1 .75 .1 .05])

function BPsimple1(duration, samples)
	# initialize matrix for results
	population = zeros(Int,duration,samples)
	population[1,:].=1

	for s in 1:size(population)[2]
		for k in 1:(size(population)[1]-1) 
			population[k+1,s] = sum(sample(collect(0:length(offspringdist)-1),offspringdist ,population[k,s];replace=true))
		end
	end

	return(population)
end

# rewrite using broadcasting for inner loop
# surprisingly only slightly faster
function BPsimple2(duration, samples)
	# initialize matrix for results
	population = zeros(Int,samples,duration)
	population[:,1].=1
	for k in 1:(size(population)[2]-1) 
		population[:,k+1] = 
			[sum(sample(collect(0:length(offspringdist)-1),offspringdist ,population[s,k];replace=true)) 
			 for s in 1:size(population)[1] ]
	end
	return(population)
end
