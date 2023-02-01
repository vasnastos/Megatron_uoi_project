# Megatron project

© 2022 MEGATRON - Πανεπηστήμιο Ιωαννίνων Τμήμα πληροφορικής και τηλεπικοινωνιών

# ΕΝΟΤΗΤΕΣ

### SERVER

* **DOCS**
  - [https://support.hpe.com/hpesc/public/docDisplay?docLocale=en_US&docId=a00109740en_us](https://support.hpe.com/hpesc/public/docDisplay?docLocale=en_US&docId=a00109740en_us)

* **GPU**
  | ΜΟΝΤΕΛΟ | Α100 |
  | -------------- | ----- |
  | ΜΝΗΜΗ     | 80GB  |
  | ΤENSOR CORES  | 432   |
  | CUDA CORES     | 6912  |

  ![fot_nvidia_a100](./server/a100.png)
* **Virtualization**:
  NVIDIA virtual GPU (vGPU) software enables powerful GPU performance for workloads ranging from graphics-rich virtual workstations to data science and AI, enabling IT to leverage the management and security benefits of virtualization as well as the performance of NVIDIA GPUs required for modern workloads. Installed on a physical GPU in a cloud or enterprise data center server, NVIDIA vGPU software creates virtual GPUs that can be shared across multiple virtual machines, accessed by any device, anywhere.
  - [https://www.nvidia.com/en-us/data-center/virtual-solutions/](https://www.nvidia.com/en-us/data-center/virtual-solutions/)
  - [https://www.lewan.com/blog/2015/03/30/vgpu-vsga-vdga-software-why-do-i-care](https://www.lewan.com/blog/2015/03/30/vgpu-vsga-vdga-software-why-do-i-care)
  - [PB-10577-001_v02.pdf](./server/PB-10577-001_v02.pdf)

* **SERVER MANUAL**
    - [HPE_a00111728en_us_HPE ProLiant XL645d Gen10 Plus Server User Guide.pdf](./server/HPE_a00111728en_us_HPE%20ProLiant%20XL645d%20Gen10%20Plus%20Server%20User%20Guide.pdf)

### ΔΕΔΟΜΕΝΑ ΚΙΝΗΣΗΣ
  * [forceplate_full_data](./datasets/Dynamic01.csv) 
  * [forceplate_momentum](./datasets/forceplate.csv)


### ΕΞΩΣΚΕΛΕΤΙΚΟ
  * Σύνδεση με εξωσκελιτικό
    - [Using the Dataport.pdf](./exoskeleton/Using%20the%20Dataport.pdf)
  
  * EksoNR
  
    **EksoNR is a wearable exoskeleton developed by Ekso Bionics. It is designed to help individuals with lower extremity mobility  impairments to walk and stand. The device is lightweight, non-invasive and provides powered assistance for knee and hip movement. The exoskeleton is battery-powered and can be adjusted to fit individuals of different sizes and weights. It is typically used in rehabilitation settings under the supervision of a trained therapist.**

    **Combining EksoNR with Artificial Neural Networks (ANNs) can be done by integrating ANNs as a control system for the exoskeleton. ANNs can be used to process sensory inputs from the exoskeleton and user, and make real-time decisions on how to assist the user's movements. The inputs to the ANN could include information such as joint angles, ground reaction forces, and user-initiated movement commands. The ANN would then use this information to generate control signals for the exoskeleton's actuators, helping to provide the desired level of assistance to the user. The integration of ANNs can also allow for the customization of the exoskeleton's assistance based on the user's specific needs and abilities. Over time, the ANN could potentially learn and adapt to the user's movements, further improving the performance of the exoskeleton.**

The type of ANN that is used for controlling the exoskeleton will depend on the specific requirements of the application and the type of sensory inputs that are available. A combination of different types of ANNs can also be used to create a hybrid control system that takes advantage of the strengths of each individual network.

There are several types of Artificial Neural Networks (ANNs) that can be used for controlling an exoskeleton such as EksoNR. Some of the common types are:

  *  Feedforward Neural Network (FFNN): This type of ANN is used for mapping input to output, where the output of one layer is used as input to the next layer. It can be used to generate control signals for the exoskeleton based on sensory inputs.

  *  Recurrent Neural Network (RNN): This type of ANN has feedback connections, allowing it to process sequences of inputs over time. It can be used to model the user's movements and provide appropriate assistance to the exoskeleton.

  *  Convolutional Neural Network (CNN): This type of ANN is designed to process visual data, such as images and videos. It can be used in combination with other types of ANNs to process visual information from cameras or other sensors, providing additional inputs to the control system.

  *  Reinforcement Learning (RL): This type of ANN is used for decision-making and learning from experience. It can be used to model the user's interactions with the exoskeleton, allowing the control system to learn and adapt over time.

### Bertec forceplates

Bertec Forceplate data can be annotated with specific events or markers to indicate important moments during a movement. Some common annotations that can be made in Bertec Forceplate data include:

  * Foot Strikes: Markers can be placed at the beginning and end of each foot strike, indicating when the foot first makes contact with the ground and when it leaves the ground.

  *  Heel Strikes: Markers can be placed at the moment when the heel first makes contact with the ground, providing information about the timing and duration of heel strike events.

  *  Toe Offs: Markers can be placed at the moment when the toe leaves the ground, providing information about the timing and duration of toe off events.

  *  Gait Cycles: Markers can be placed at the beginning and end of each gait cycle, indicating when a full cycle of movement has been completed.

  *  Peaks and Valleys: Markers can be placed at the maximum and minimum values of specific variables, such as force or velocity, providing information about the timing and magnitude of these events.

The specific annotations that are made in Bertec Forceplate data will depend on the specific research questions being asked and the information that is needed to answer those questions. The annotations can be used to calculate a variety of biomechanical parameters and to create visual representations of the data, providing insights into the mechanics of human movement.

### ΔΗΜΟΣΙΕΥΣΕΙΣ
   * [https://ieeexplore.ieee.org/abstract/document/9932971](https://ieeexplore.ieee.org/abstract/document/9932971)
  

   >@INPROCEEDINGS{9932971,

   >author={Nastos, Vasileios and Arjmand, Alexandros and Tsakai, Klevis and Dimopoulos, Dimitrios and Varvarousis, Dimitrios and Tzallas, Alexandros and Giannakeas, Nikolaos and Ploumis, Avraam and Gogos, Christos},
   >booktitle={2022 7th South-East Europe Design Automation, Computer Engineering, Computer Networks and Social Media Conference (SEEDA-CECNSM)}, 
   >title={Human Activity Recognition using Machine Learning Techniques}, 
   >year={2022},
   >volume={},
   >number={},
   >pages={1-5},
   >doi={10.1109/SEEDA-CECNSM57760.2022.9932971}}
