model = Model(HiGHS.Optimizer)
@variable(model, chairs >= 0)
@variable(model, tables >= 0)

@objective(model, Max, 200*tables + 100*chairs)

@constraint(model, wood, 30*tables + 10*chairs <= 300)
@constraint(model, labor, 5*tables + 3*chairs <= 40)
@constraint(model, space, 20*tables + 2*chairs <= 120)
model

	@variable(model, 2 <= u[i=2:n] <= n, Int)

	for i in 2:n
        for j in 2:n
            if i != j
                @constraint(model, 
                    # u[i] - u[j] + n * x[i,j] <= n-1
					# u[i] + x[i, j] <= u[j] + (n-1)*(1-x[i, j])
					u[i] - u[j] + 1 <= (n-1)*(1-x[i,j])
				)
            end
        end
    end
    
    	for j in 1:n
		@constraint(model, sum(x[i, j] for i in 1:n if i != j) == 1)
	end

	for i in 1:n
		@constraint(model, sum(x[i, j] for j in 1:n if i != j) == 1)
	end
