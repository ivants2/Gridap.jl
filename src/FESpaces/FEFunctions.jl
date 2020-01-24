
"""
Types marked with this trait need to implement the following queries

- [`get_free_values(object)`]
- [`get_fe_space(object)`]

"""
FEFunctionStyle(::Type{T}) where T = Val{false}()

FEFunctionStyle(fe_function) = FEFunctionStyle(typeof(fe_function))

"""
"""
function is_a_fe_function(fe_function)
  v = FEFunctionStyle(fe_function)
  get_val_parameter(v)
end

function is_a_fe_function(::Type)
  @unreachable "is_a_fe_function cannot be called on types"
end

"""
"""
function get_free_values(object)
  @abstractmethod
end

"""
"""
function get_fe_space(object)
  @abstractmethod
end

"""
"""
function test_fe_function(f)
  @test is_a_fe_function(f)
  free_values = get_free_values(f)
  fe_space = get_fe_space(f)
  @test length(free_values) == num_free_dofs(fe_space)
end

