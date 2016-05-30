studyforrest.org Dataset
************************

|license| |access|

Pre-aligned MRI data
====================

This repository contains data derived from the raw data releases of the
*studyforrest.org* project. In particular these are:

* BOLD fMRI timeseries aligned to subject-specific template images
  and using transformations available from 
  https://github.com/psychoinformatics-de/studyforrest-data-templatetransforms

For more information about the project visit: http://studyforrest.org

File name conventions
---------------------

Each directory in the subject directories corresponds to one template image
space. Data in ``sub*`` directories are participant-specific (not aligned
across participants). However, templates with
the same name have corresponding input data.

Each directory contains one or more image files with more-or-less
self-explanatory names, identifying the corresponding participant and scan.

Lastly, the ``code/`` directory contains the source code for computing all
files contained, as well as a number of validation analyses.


How to obtain the dataset
-------------------------

This repository contains metadata and information on the identity of all
included files. However, the actual content of the (sometime large) data
files is stored elsewhere. To obtain any dataset component, git-annex_ is
required in addition to Git_.

1. Clone this repository to the desired location.
2. Enter the directory with the local clone and run::

     git annex init

   Older versions of git-annex may require you to run the following
   command immediately afterwards::

     git annex enableremote mddatasrc

Now any desired dataset component can be obtained by using the ``git annex get``
command. To obtain the entire dataset content run::

     git annex get .


Keep data up-to-date
--------------------

If updates to this dataset are made in the future, update any local clone by
running::

     git pull

followed by::

     git annex get .

to fetch all new files.




.. _Git: http://www.git-scm.com

.. _git-annex: http://git-annex.branchable.com/

.. |license|
   image:: https://img.shields.io/badge/license-PDDL-blue.svg
    :target: http://opendatacommons.org/licenses/pddl/summary
    :alt: PDDL-licensed

.. |access|
   image:: https://img.shields.io/badge/data_access-unrestricted-green.svg
    :alt: No registration or authentication required
