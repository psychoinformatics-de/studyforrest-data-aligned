from mvpa2.suite import fmri_dataset, vstack
import numpy as np
import nibabel as nb


def preprocessed_fmri_dataset(
        bold_fname, preproc_img=None, preproc_ds=None, add_sa=None,
        **kwargs):
    """

    Parameters
    ----------
    bold_fname : str
      File name of BOLD scan
    preproc_img : callable or None
      See get_bold_run_dataset() documentation
    preproc_ds : callable or None
      If not None, this callable will be called with each run bold dataset
      as an argument before ``modelfx`` is executed. The callable must
      return a dataset.
    add_sa : dict or None

    Returns
    -------
    Dataset
    """
    # open the BOLD image
    bold_img = nb.load(bold_fname)

    if not preproc_img is None:
        bold_img = preproc_img(bold_img)
    # load (and mask) data
    ds = fmri_dataset(bold_img, **kwargs)

    if not add_sa is None:
        for sa in add_sa:
            ds.sa[sa] = add_sa[sa]

    if not preproc_ds is None:
        ds = preproc_ds(ds)
    return ds


def movie_dataset(subj, task, label, **kwargs):
    # ds = movie_dataset(
    #       2,
    #       'avmovie',
    #       'bold3Tp2',
    #       mask='src/tnt/sub-02/bold3Tp2/brain_mask.nii.gz')
    cur_max_time = 0
    segments = []
    if not 'add_sa' in kwargs:
        add_sa = {}
    for seg in range(1, 9):
        print 'Seg', seg
        mc = np.recfromtxt(
            'sub-%.2i/in_%s/sub-%.2i_task-%s_run-%i_bold_mcparams.txt'
            % (subj, label, subj, task, seg),
            names=('mc_xtrans', 'mc_ytrans', 'mc_ztrans', 'mc_xrot',
                   'mc_yrot', 'mc_zrot'))
        for i in mc.dtype.fields:
            add_sa[i] = mc[i]
        ds = preprocessed_fmri_dataset(
            'sub-%.2i/in_%s/sub-%.2i_task-%s_run-%i_bold.nii.gz'
            % (subj, label, subj, task, seg),
            add_sa=add_sa,
            **kwargs)
        ds.sa['movie_segment'] = [seg] * len(ds)
        TR = np.diff(ds.sa.time_coords).mean()
        ## truncate segment time series to remove overlap
        if seg > 1:
            ds = ds[4:]
        if seg < 8:
            ds = ds[:-4]
        ds.sa['movie_time'] = np.arange(len(ds)) * TR + cur_max_time
        cur_max_time = ds.sa.movie_time[-1] + TR
        segments.append(ds)
    return vstack(segments)
