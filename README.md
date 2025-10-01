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
@article{He2025,
  title = {Metaheuristic generation of brane tilings},
  volume = {862},
  ISSN = {0370-2693},
  url = {http://dx.doi.org/10.1016/j.physletb.2025.139365},
  DOI = {10.1016/j.physletb.2025.139365},
  journal = {Physics Letters B},
  publisher = {Elsevier BV},
  author = {He,  Yang-Hui and Jejjala,  Vishnu and Silva,  Tomás S.R.},
  year = {2025},
  month = mar,
  pages = {139365}
}
```

# References

[1] Hanany, A., Jejjala, V., Ramgoolam, S., and Seong, R.-K., “Consistency and derangements in brane tilings”, <i>Journal of Physics A Mathematical General</i>, vol. 49, no. 35, Art. no. 355401, IOP, 2016. doi:10.1088/1751-8113/49/35/355401.

[2] He, Y.-H., Jejjala, V., and Silva, T. S. R., “Metaheuristic Generation of Brane Tilings”, <i>arXiv e-prints</i>, Art. no. arXiv:2412.19313, 2024.