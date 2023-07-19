from importlib import reload
import sys

import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np

if sys.platform == "darwin":
    mpl.use("MacOSX")
else:
    mpl.use("agg")

plt.style.use("paper")
