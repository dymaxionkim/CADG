---
title: "엘머로 해 보는 동역학(Implicit Dynamics) 해석"
author: DymaxionKim
date: 2017-08-??
geometry: "left=3cm,right=2cm,top=3cm,bottom=2cm"
mainfont: Noto Sans CJK KR
monofont: D2Coding
fontsize: 10pt
papersize: "a4paper"
output: pdf_document
---

## 1. 개요

* 본편에서는, 지난 시간과 동일한 신라종(Bell) 형상 매쉬와 `Linear Elasticity` 물리방정식을 적용하여, 물체의 동적인 거동 부분을 해석해 본다.
* 먼저 감쇠가 고려되지 않은 기본적인 시간영역에서의 동적응답을 얻어내 보고, 이후 상수 감쇠계수 및 선형 감쇠계수모델을 각각 적용해서 거동을 비교해 본다.
* 아울러 고유모드 해석도 해 보고, 특정 주파수로 물체에 강제진동을 줬을 때의 주파수영역 응답을 알아내 보는 하모닉 해석도 해 본다.

## 2. 무감쇠 동적응답 (CASE1)

### (1) 먼저 고려해 볼 사항들
* 본 해석 방법은, 초기조건에서 물체 자체를 약간 잡아당겼다가 탁하고 놓도록 해서 일종의 충격을 받는 효과를 노리는 것이다.
* 일단 시간영역에서의 응답을 보는 것이 목표이므로, 시뮬레이션 조건은 `Transient`로 해 주고, 물체의 재질과 형상 및 사이즈 등을 고려하여 어느정도 주파수대의 진동에 관심이 있는지를 먼저 결정한다.  본 예제의 경우에는 1kHz(0.001초) 정도로 잘라보도록 하고, 100회 동안 추적하여 총 0.1초의 응답을 들여다보려고 한다.

### (2) `case1.sif` 작성
* 지난시간을 통해 ElmerGUI의 사용방법을 습득하였다면, 이를 이용해서 충분히 작성할 수 있을 것이다.  결과로 나온 `case1.sif` 파일은 아래와 같다.

```c
Header
  CHECK KEYWORDS Warn
  Mesh DB "." "."
  Include Path ""
  Results Directory "CASE1"     ! 결과파일이 저장되는 장소.  미리 동일한 이름의 디렉토리를 만들어 두어야 한다.
End

Simulation
  Max Output Level = 5
  Coordinate System = Cartesian
  Coordinate Mapping(3) = 1 2 3
  Simulation Type = Transient     ! 해석조건은 Transient로 해서 시간에 따른 거동을 보려고 한다.
  Steady State Max Iterations = 1
  Output Intervals = 1
  Timestepping Method = BDF
  BDF Order = 1
  Timestep intervals = 100     ! 100번의 샷을 얻어내고자 한다.
  Timestep Sizes = 0.001       ! 시간 간격은 0.001초
  Solver Input File = case1.sif     ! 인풋파일 이름을 정확히 설정하자.
  Post File = case1.vtu             ! 결과 파일 이름도 명확하게 하자.
Coordinate Scaling = 0.001     ! 원래의 매쉬모델의 길이단위가 밀리미터 였다면 미터 단위로 변환하는 것을 잊지 말자.
End

Constants
  Gravity(4) = 0 0 -1 9.82
  Stefan Boltzmann = 5.67e-08
  Permittivity of Vacuum = 8.8542e-12
  Boltzmann Constant = 1.3807e-23
  Unit Charge = 1.602e-19
End

Body 1
  Target Bodies(1) = 2
  Name = "Body 1"
  Equation = 1
  Material = 1
  Body Force = 1
  Initial condition = 1
End

Solver 1
  Equation = Linear elasticity
  Calculate Stresses = True
  Variable = -dofs 3 Displacement
  Procedure = "StressSolve" "StressSolver"
  Exec Solver = Always
  Stabilize = True
  Bubbles = False
  Lumped Mass Matrix = False
  Optimize Bandwidth = True
  Steady State Convergence Tolerance = 1.0e-5
  Nonlinear System Convergence Tolerance = 1.0e-7
  Nonlinear System Max Iterations = 20
  Nonlinear System Newton After Iterations = 3
  Nonlinear System Newton After Tolerance = 1.0e-3
  Nonlinear System Relaxation Factor = 1
  Linear System Solver = Iterative
  Linear System Iterative Method = BiCGStab     ! Transient 해석에서 가장 무난함.
  Linear System Max Iterations = 500
  Linear System Convergence Tolerance = 1.0e-5     ! 계산속도를 높이기 위해 정밀도를 좀 낮춰 주었음.
  BiCGstabl polynomial degree = 2
  Linear System Preconditioning = Diagonal
  Linear System ILUT Tolerance = 1.0e-3
  Linear System Abort Not Converged = False
  Linear System Residual Output = 1
  Linear System Precondition Recompute = 1
End

Equation 1
  Name = "Equation 1"
  Calculate Stresses = True
  Active Solvers(1) = 1
End

Material 1
  Name = "Bronze"
  Poisson ratio = 0.34
  Youngs modulus = 1.2236595E+10
  Porosity Model = Always saturated     ! 본 해석에서는 불필요함 (삭제해도 무방)
  Density = 8800
End

Body Force 1
  Name = "Gravitation"
  Stress Bodyforce 3 = $(-9.81*8800)     ! 중력에 의해 물체 전체에 자중이 걸리도록 한 것
End

Initial Condition 1
  Name = "InitialCondition 1"
  Displacement 1 = -0.005      ! 물체를 5mm 정도 살짝 당겨주고 시작하도록 함
End

Boundary Condition 1
  Target Boundaries(1) = 5
  Name = "Fix"
  Displacement 3 = 0
  Displacement 1 = 0
  Displacement 2 = 0
End
```

## 3. 감쇠계수를 상수로 부여한 동적응답 (CASE2)

## 4. 레일리 감쇠모델을 적용한 동적응답 (CASE4)

## 5. 고유모드 해석 (CASE3)

## 6. 하모닉 해석 (CASE5,CASE6)

## 7. 맺음말

## 참고자료

* 비례감쇄 설명 : http://nfx.co.kr/techpaper/keyword_view.asp?pg=&sk=&bid=&nCat=&nIndex=&sHtml=&idx=229

* 비례감쇄 이론 : http://www.kim2kie.com/cafeUpload/Databoard/files/320_03_01_damping_pro.pdf
