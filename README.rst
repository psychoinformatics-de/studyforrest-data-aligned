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

This repository is a `DataLad <https://www.datalad.org/>`__ dataset. It provides
fine-grained data access down to the level of individual files, and allows for
tracking future updates. In order to use this repository for data retrieval,
`DataLad <https://www.datalad.org>`_ is required.
It is a free and open source command line tool, available for all
major operating systems, and builds up on Git and `git-annex
<https://git-annex.branchable.com>`__ to allow sharing, synchronizing, and
version controlling collections of large files. You can find information on
how to install DataLad at `handbook.datalad.org/en/latest/intro/installation.html
<http://handbook.datalad.org/en/latest/intro/installation.html>`_.

Get the dataset
^^^^^^^^^^^^^^^

A DataLad dataset can be ``cloned`` by running::

   datalad clone <url>

Once a dataset is cloned, it is a light-weight directory on your local machine.
At this point, it contains only small metadata and information on the
identity of the files in the dataset, but not actual *content* of the
(sometimes large) data files.

Retrieve dataset content
^^^^^^^^^^^^^^^^^^^^^^^^

After cloning a dataset, you can retrieve file contents by running::

   datalad get <path/to/directory/or/file>

This command will trigger a download of the files, directories, or
subdatasets you have specified.

DataLad datasets can contain other datasets, so called *subdatasets*. If you
clone the top-level dataset, subdatasets do not yet contain metadata and
information on the identity of files, but appear to be empty directories. In
order to retrieve file availability metadata in subdatasets, run::

   datalad get -n <path/to/subdataset>

Afterwards, you can browse the retrieved metadata to find out about
subdataset contents, and retrieve individual files with ``datalad get``. If you
use ``datalad get <path/to/subdataset>``, all contents of the subdataset will
be downloaded at once.

Keep data up-to-date
^^^^^^^^^^^^^^^^^^^^

DataLad datasets can be updated. The command ``datalad update`` will *fetch*
updates and store them on a different branch (by default
``remotes/origin/master``). Running::

   datalad update --merge

will *pull* available updates and integrate them in one go.

Find out what has been done
^^^^^^^^^^^^^^^^^^^^^^^^^^^

DataLad datasets contain their history in the ``git log``.
By running ``git log`` (or a tool that displays Git history) in the dataset or on
specific files, you can find out what has been done to the dataset or to individual files
by whom, and when.

More information
^^^^^^^^^^^^^^^^

More information on DataLad and how to use it can be found in the DataLad Handbook at
`handbook.datalad.org <http://handbook.datalad.org/en/latest/index.html>`_. The
chapter "DataLad datasets" can help you to familiarize yourself with the
concept of a dataset.

.. |license|
   image:: https://img.shields.io/badge/license-PDDL-blue.svg
    :target: http://opendatacommons.org/licenses/pddl/summary
    :alt: PDDL-licensed

.. |access|
   image:: https://img.shields.io/badge/data_access-unrestricted-green.svg
    :alt: No registration or authentication required
