# Metaheuristic Generation of Brane Tilings
This repository presents a combinatorial optimization approach, leveraging Simulated Annealing (SA), to search for new geometrically consistent brane tilings [2].

# File Description

- ```consistency_conditions_binary.sage``` : Boolean verification of geometric consistency conditions as in [1]
- ```consistency_conditions_scores.sage``` : Implement the consistency scoring routings as described in Appendix A of [2]
- ```SA_demo.ipynb```: Demo file with the SA search for new theories
-  ```PermToQuiver.ipynb```: Code for converting permutation pairs into quiver gauge theories
-  ```requirements.txt```: Libraries required. Run ```pip install -r ./requirements.txt```  

# BibTex Citation 
```
@misc{he2024metaheuristicgenerationbranetilings,
      title={Metaheuristic Generation of Brane Tilings}, 
      author={Yang-Hui He and Vishnu Jejjala and Tom\'as S. R. Silva},
      year={2024},
      eprint={2412.19313},
      archivePrefix={arXiv},
      primaryClass={hep-th},
      url={https://arxiv.org/abs/2412.19313}, 
}
```

# References

[1] Hanany, A., Jejjala, V., Ramgoolam, S., and Seong, R.-K., “Consistency and derangements in brane tilings”, <i>Journal of Physics A Mathematical General</i>, vol. 49, no. 35, Art. no. 355401, IOP, 2016. doi:10.1088/1751-8113/49/35/355401.

[2] He, Y.-H., Jejjala, V., and Silva, T. S. R., “Metaheuristic Generation of Brane Tilings”, <i>arXiv e-prints</i>, Art. no. arXiv:2412.19313, 2024.