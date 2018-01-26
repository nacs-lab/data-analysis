function str = logical_cond_2str(logical_cond, single_atom_species)
    str = '[';
    for i = 1:length(logical_cond)
        im = logical_cond(i);
        if i > 1
            str = [str, ' '];
        end
        str = [str, int2str(im), ' ', single_atom_species{abs(im)}];
        if i < length(logical_cond)
            str = [str, ','];
        end
%         if i > 1
%             str = [str, '&'];
%         end 
%         if im > 0
%             str = [str, single_atom_species{im}];
%         else
%             str = [str, '!', single_atom_species{abs(im)}];
%         end
    end
    str = [str ']'];
end
