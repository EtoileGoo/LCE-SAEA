function [parent,mut_strength,fp,Nex] = kill_bad_mnl(parent,fp,mut_strength,Problem,id_nex,Boundary,direction,Nex)

    %mut_strength is sigma variation
    [N,D] = size(parent);
    upper = Boundary(1,:);
    lower = Boundary(2,:);
    lambda = N;
    l = 1;
    kid = zeros(N,D);
    xmean = mean(parent,1);

    while l < lambda
        
        Offspring = xmean + mut_strength.*randn(N,D);
        for i = 1:N
            if all(Offspring(i,:)<=upper)  && all(Offspring(i,:)>=lower)
                kid(l,:) = Offspring(i,:);
                l = l+1;
            end
        end
    end
    kid = kid(1:lambda,:);
    fk = evaluate_least_expensive_obj(kid,Problem,id_nex,D);
    f = [fp;fk];
    pop = [parent;kid];
    Nex = [Nex;[kid,fk]];

    [~,index] = sort(f,direction);
    parent = pop(index(1:N),:);
    fp = f(index(1:N),1);

    
    mut_strength =  std(parent, 0, 1);
end

