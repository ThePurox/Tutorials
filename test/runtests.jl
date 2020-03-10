using Tutorials
using Random
using Test

Random.seed!(0);

for (title,filename) in Tutorials.files
    # Create temporal modules to isolate and protect test scopes
    tmpfile = string("module_",randstring(['A':'Z'; '0':'9'], 12))
    isfile(tmpfile) && error("File $tmpfile already exists!")
    testpath = joinpath("../src", filename)
    open(tmpfile,"w") do f
      println(f, "# This file is automatically generated")
      println(f, "# Do not edit")
      println(f)
      println(f, "module $tmpfile include(\"$testpath\") end")
    end
    @testset "$title" begin include(tmpfile) end
    rm(tmpfile)
end 

