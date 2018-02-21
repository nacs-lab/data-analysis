function testFunction(var, varargin)

var;
defaultCutoff = 1;
p = inputParser;
addParameter(p, 'Cutoff', defaultCutoff, @isnumeric)
addParameter(p, 'Test', defaultCutoff, @isnumeric)


parse(p, varargin{:});
Cutoff = p.Results.Cutoff;


end
