module GeometryTests

using Test
using Numa
using Numa.FieldValues
using Numa.CellValues
using Numa.Geometry
using Numa.Polytopes
using Numa.Vtkio

@testset "CartesianGrid" begin

  grid = CartesianGrid(domain=(0.0,1.0,-1.0,2.0),partition=(3,4))

  x = points(grid)

  @test isa(x,CellValue{Point{2}})

  @test length(x) == 20
  @test x[13] == [0.0,1.25]
  @test x[4] == [1.0,-1.0]
  @test x[1] == [0.0,-1.0]
  @test x[end] == [1.0,2.0]

  t = cells(grid)

  @test isa(t,CellArray{Int,1})

  @test length(t) == 12

  @test t[1] == [1,2,5,6]
  @test t[11] == [14,15,18,19]

  c = celltypes(grid)
  @test isa(c,ConstantCellValue{NTuple{2,Int}})
  @test celldata(c) == (HEX_AXIS,HEX_AXIS)
  @test length(c) == 12

end

@testset "FlexibleUnstructuredGrid" begin

  cgrid = CartesianGrid(domain=(0.0,1.0,-1.0,2.0),partition=(3,4))

  grid = FlexibleUnstructuredGrid(cgrid)

  d = mktempdir()
  f = joinpath(d,"grid")

  writevtk(grid,f)

  rm(d,recursive=true)

end

@testset "UnstructuredGrid" begin

  cgrid = CartesianGrid(domain=(0.0,1.0,-1.0,2.0),partition=(3,4))

  grid = UnstructuredGrid(cgrid)

  d = mktempdir()
  f = joinpath(d,"grid")

  writevtk(grid,f)

  rm(d,recursive=true)

end

end # module GeometryTests