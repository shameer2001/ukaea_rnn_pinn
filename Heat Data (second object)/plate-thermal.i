[Mesh]
  type = FileMesh
  file = 'simple.e'
[]

[Variables]
  [temperature] 
    order = FIRST
    family = LAGRANGE
  []
[]

[ICs]
  [temperature_1]
    type = ConstantIC
    variable = temperature
    value = 300
    block = 'copper'
  []
  [temperature_2]
    type = ConstantIC
    variable = temperature
    value = 300
    block = 'glass'
  []
[]

[Kernels]
 [conduction]
   type = ADHeatConduction
   variable = temperature
   thermal_conductivity = 'k'
 []
 [conduction_dt]
   type = ADHeatConductionTimeDerivative
   variable = temperature
 []
[]

[BCs]
  [cold-in-temp]
    type = ADDirichletBC
    boundary = 'cold'
    variable = temperature
    value = 300
  []
  [hot-in-temp]
    type = ADDirichletBC
    boundary = 'hot'
    variable = temperature
    value = 900
  []
[]
  
[Materials]
  [copper]
    type = ADGenericConstantMaterial    
    prop_names = 'density specific_heat k'
#    prop_values = '998.4 4194.0 0.6 '
#    prop_values = '1 1 4194.0 0.6 2.14e-4'
    prop_values = '8900 386 1e6'
    block = 'copper'
  []
  [glass]
    type = ADGenericConstantMaterial
    prop_names = 'density specific_heat k'
    prop_values = '2500 840 100'
    block = 'glass'
  []
[]
  
[Preconditioning]
  [SMP]
    type = SMP
    full = true
    solve_type = 'NEWTON'
  []
[]

  
[Executioner]
  type = Transient
  dt = 10
  dtmin = 10
  start_time = 0.0
  end_time = 1000.0
#  petsc_options_iname = '-pc_type -pc_hypre_type'
#  petsc_options_value = ' hypre   euclid'
  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_type -ksp_rtol'
  petsc_options_value = ' hypre   boomeramg  gmres  1e-2'
  line_search = 'none'
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-6
  nl_max_its = 6
  l_tol = 1e-8
  l_max_its = 300
  automatic_scaling = true
  #steady_state_detection = true
[]

[Outputs]
  [out]
    type = Exodus
  []
[]
