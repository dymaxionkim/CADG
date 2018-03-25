---
title: "엘머로 해 보는 대류열전달(Heat Convection) 해석"
author: DymaxionKim
date: 2017-08-??
geometry: "left=3cm,right=2cm,top=3cm,bottom=2cm"
mainfont: Noto Sans CJK KR
monofont: D2Coding
fontsize: 10pt
papersize: "a4paper"
header-includes:
 - \usepackage{fancyhdr}
 - \pagestyle{fancy}
 - \fancyhead[CO,CE]{엘머로 해 보는 오픈소스 엔지니어링}
 - \fancyfoot[CO,CE]{CAD\&Graphics}
 - \fancyfoot[LE,RO]{\thepage}
output: pdf_document
---

## 1. 개요
* 엘머에서 제공하는 유체동역학 해석 방법은 유한요소법(FEM)인데, 이는 다른 전문적인 CFD 소프트웨어들이 제공하는 유한체적법(FVM)보다 단점이 많다고 한다.  몇 가지 한계점이 있는데, 우선 조건에 따라 수렴에 실패할 확률이 상대적으로 높다.  때문에 대체로 가급적 레이놀즈수가 너무 높아지지 않도록 조건을 잡아줄 필요가 있다.  달리말해, 아음속/초음속 수준의 압축성 유체거동을 해석하거나 하는 등의 극단적인 케이스를 다루기가 꽤 곤란하다는 점이다.  이런 문제를 풀 때는 전문적인 전용 소프트웨어를 사용하는 것이 좋겠다.  오픈소스로도 OpenFOAM, SU2 등의 좋은 코드들이 있으므로 대안이 충분히 있다.
* 또한 기본적으로 제공해 주는 난류모델이 기본적인 것(RANS 모델) 밖에 없다.  k-epsilon 및 k-omega 모델이 그것이고, 이보다 더욱 엄밀한 LES 모델은 별도로 구현하거나 다른 사람이 성공한 예제를 찾아서 따라하는 수 밖에 없다.  난류 경계층 내부의 격렬한 거동을 살펴볼 것이 아닌 일반적인 경우라면 k-epsilon 모델로도 충분하다고 생각된다.
* 본 예제에서는 이런 제한사항들을 염두에 두면서, 기본적인 형태의 히트싱크에 공기가 흘러가는 형태를 시뮬레이션해 보고, 이러한 유체거동에 의한 대류열전달 현상을 관찰해 보기로 한다.

## 2. 시스템 모델
* 본 예제에서는, 복수의 냉각핀(fins)이 돌출되어있는 형태의 알미늄 히트싱크 형태를 모델링하고, 공기와의 접촉면에서 열교환이 발생하도록 적절한 열전달계수를 부여한다.  그리고 히트싱크 아래면의 일부(발열원 부분)에서 발열이 일어나도록 경계조건을 부여할 것이다.
* 따라서 열전달 경로는, 발열면 - 히트싱크 내부(열전도) - 히트싱크와 공기의 접촉면(열전도) - 공기(대류열전달) 순서로 일어날 것이다.
* 공기의 대류열전달 모델은, 나비에-스톡스 방정식(Navier-Stokes Eq.)과 열방정식(Heat Eq.)을 동시에 적용한다.  여기에 k-epsilon 난류모델도 추가하여 적용해 본다.
* 아울러, 중력 방향을 설정하고 이에 영향을 받아 부력(buoyancy)이 작용하도록 엘머에서 제공하는 부시네스크 근사모델(Boussinesq approximation)을 적용한다.
* 공기의 흐름은, 자연대류를 관찰하고자 할 경우에는 초기값을 아주 약간의 속도만 주고, 입출구 유동이 없도록 잡아주면 된다.  강제대류의 경우, 입구에 적절한 유체 속도값을 주고 출구의 압력을 0으로 해 주는 것이 기본적인 방법이 될 수 있을 것이다.

## 3. 전처리 과정

### (1) 3D 모델링
* 계획한 바와 같이 우선 알미늄 히트싱크 형상을 모델링한다.  이때, 발열면 부분을 별도의 패치(Patch)가 되도록 면을 분리해 주고 모델링하면 경계조건 부여할 때 편리할 것이다.
* 공기 영역 역시 별도로 모델링한 후, 히트싱크 부분의 영역을 미리 잘라내 준다.
* 이상 모델링된 형상은 공깅화 히트싱크 2개의 물체로 구성된다고 볼 수 있을 것이다.

### (2) 매쉬 작업
* 가장 간편한 방법은, 지난 호에서 소개한 step2unv.py 스크립트를 이용하여 자동화한 Salome 작업을 실시하도록 하는 것이다.
* 또는 그다지 복잡한 형태는 아니기 때문에, 직접 Salome GUI에서 매쉬 작업을 실시해도 무방하다.






### step2unv

* Download and Path (on Linux)

```bash
mkdir ~/.config/salome/step2unv
wget -O ~/.config/salome/step2unv/step2unv https://raw.githubusercontent.com/dymaxionkim/ElmerFEM_Examples/master/20170911_Salome_Script_STEP2UNV/step2unv
wget -O ~/.config/salome/step2unv/step2unv.py https://raw.githubusercontent.com/dymaxionkim/ElmerFEM_Examples/master/20170911_Salome_Script_STEP2UNV/step2unv.py
wget -O ~/.config/salome/step2unv/Readme.md https://raw.githubusercontent.com/dymaxionkim/ElmerFEM_Examples/master/20170911_Salome_Script_STEP2UNV/Readme.md
chmod +x ~/.config/salome/step2unv/step2unv
echo "" >> ~/.bashrc
echo "# STEP2UNV for Elmer with Salome" >> ~/.bashrc
echo "export PATH=\"/home/osboxes/.config/salome/step2unv:\$PATH\"" >> ~/.bashrc
echo "" >> ~/.bashrc
```

## How to use

* Prepare geometry files
  - Format : STEP
  - Single STEP file that includes multi bodies
  - No interferences with two bodies, but only Contact
  - The STEP files should be in the working directory

* Excecute script

```bash
$ step2unv
runSalome running on CQ57
INFO:MainThread:Problem loading PortManager file: /tmp/.omniORB_PortManager.cfg
INFO:PortManager:Problem loading PortManager file: /tmp/.omniORB_PortManager.cfg
Searching for a free port for naming service: 2810 - OK
Searching Naming Service + found in 0.1 seconds 
Searching /Registry in Naming Service + found in 0.5 seconds 
Searching /Kernel/ModulCatalog in Naming Service +th. 140357089298240 - Trace /volatile/salome/SALOME-8.2.0-UB16.04/SOURCES/KERNEL/src/ModuleCatalog/SALOME_ModuleCatalog_Server.cxx [101] : Module Catalog Server: Naming Service was found
Warning: this type (Study,objref) already exists, it will be ignored.
 found in 0.5 seconds 
RunStudy
Searching /myStudyManager in Naming Service ++ found in 1.0 seconds 
Searching /Containers/CQ57/FactoryServer in Naming Service +Warning, no type found for resource "localhost", using default value "single_machine"
++ found in 1.5 seconds 
Start SALOME, elapsed time :   3.7 seconds
createNewStudy
extStudy 1
----------------------------------------------------
Input your working directory :
/home/osboxes/github/Elmer_Examples_for_CADG/CADG_07_Elmer_Convection/2.step2unv
----------------------------------------------------
Input your STEP File Name :
HeatSink.step
----------------------------------------------------
----- Mesh Parameters -----
MinMeshSize[m] : 0
MaxMeshSize[m] : 5
SetFiness ::: 0=VeryCoarse, 1=Coarse, 2=Moderate, 3=Fine, 4=VeryFine, 5=Custom
SetFineness[0~5] : 3
----------------------------------------------------
----- Read STEP file ... 
----------------------------------------------------
----- Mesh Computing ... 
----------------------------------------------------
----- Make UNV ... 
----------------------------------------------------
Information about mesh:
Number of nodes       :  14653
Number of edges       :  690
Number of faces       :  1694
          triangles   :  1694
          quadrangles :  0
          polygons    :  0
Number of volumes     :  10360
          tetrahedrons:  10360
          hexahedrons :  0
          prisms      :  0
          pyramids    :  0
          polyhedrons :  0
----------------------------------------------------
----- FINISHED ! -----
Terminating SALOME on port 2810...
th. 140076293261056 - Trace /volatile/salome/SALOME-8.2.0-UB16.04/SOURCES/KERNEL/src/NamingService/SALOME_NamingService.cxx [1379] : Destroy_Directory(): CosNaming::NamingContext::NoEmpty /Study/ is not empty
It takes 68 seconds to complete this task.
osboxes@CQ57:~$ step2unv
runSalome running on CQ57
Searching for a free port for naming service: 2810 - OK
Searching Naming Service + found in 0.1 seconds 
Searching /Registry in Naming Service + found in 0.5 seconds 
Searching /Kernel/ModulCatalog in Naming Service +th. 140296960812864 - Trace /volatile/salome/SALOME-8.2.0-UB16.04/SOURCES/KERNEL/src/ModuleCatalog/SALOME_ModuleCatalog_Server.cxx [101] : Module Catalog Server: Naming Service was found
Warning: this type (Study,objref) already exists, it will be ignored.
 found in 0.5 seconds 
RunStudy
Searching /myStudyManager in Naming Service + found in 0.5 seconds 
Searching /Containers/CQ57/FactoryServer in Naming Service +Warning, no type found for resource "localhost", using default value "single_machine"
++ found in 1.5 seconds 
Start SALOME, elapsed time :   3.2 seconds
createNewStudy
extStudy 1
----------------------------------------------------
Input your working directory :
/home/osboxes/github/Elmer_Examples_for_CADG/CADG_07_Elmer_Convection/2.step2unv
----------------------------------------------------
Input your STEP File Name :
HeatSink.step
----------------------------------------------------
----- Mesh Parameters -----
MinMeshSize[m] : 0
MaxMeshSize[m] : 0.005
SetFiness ::: 0=VeryCoarse, 1=Coarse, 2=Moderate, 3=Fine, 4=VeryFine, 5=Custom
SetFineness[0~5] : 3
----------------------------------------------------
----- Read STEP file ... 
----------------------------------------------------
----- Mesh Computing ... 
----------------------------------------------------
----- Make UNV ... 
----------------------------------------------------
Information about mesh:
Number of nodes       :  211008
Number of edges       :  1618
Number of faces       :  14066
          triangles   :  14066
          quadrangles :  0
          polygons    :  0
Number of volumes     :  148848
          tetrahedrons:  148848
          hexahedrons :  0
          prisms      :  0
          pyramids    :  0
          polyhedrons :  0
----------------------------------------------------
----- FINISHED ! -----
Terminating SALOME on port 2810...
th. 140062467528448 - Trace /volatile/salome/SALOME-8.2.0-UB16.04/SOURCES/KERNEL/src/NamingService/SALOME_NamingService.cxx [1379] : Destroy_Directory(): CosNaming::NamingContext::NoEmpty /Study/ is not empty
It takes 89 seconds to complete this task.
```




