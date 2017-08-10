
% Diffusion_Cell = g_ls('/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/Process/*/Diffusion/');

for i = 1:length(Diffusion_Cell)
    data_file = [Diffusion_Cell{i} '/data'];
    mask_file = [Diffusion_Cell{i} '/nodif_brain_mask'];
    bvec_file = [Diffusion_Cell{i} '/bvecs'];
    bval_file = [Diffusion_Cell{i} '/bvals'];
    grad_file = [Diffusion_Cell{i} '/grad_dev.nii.gz'];
    [ParentFolder, ~, ~] = fileparts(Diffusion_Cell{i});
    ID_Str = ParentFolder(end - 5:end);
    out_file = [Diffusion_Cell{i} '/' ID_Str];
    
    Job_Name = ['dtifit_' num2str(i)];
    pipeline.(Job_Name).command = 'system([''dtifit -k '' opt.data '' -m '' opt.mask '' -r '' opt.bvec '' -b '' opt.bval '' --gradnonlin='' opt.grad '' -o '' opt.out ])';
    pipeline.(Job_Name).opt.data = data_file;
    pipeline.(Job_Name).opt.mask = mask_file;
    pipeline.(Job_Name).opt.bvec = bvec_file;
    pipeline.(Job_Name).opt.bval = bval_file;
    pipeline.(Job_Name).opt.grad = grad_file;
    pipeline.(Job_Name).opt.out  = out_file;
end

psom_gb_vars

Pipeline_opt.mode = 'batch';
% Pipeline_opt.qsub_options = '-q all.q';
Pipeline_opt.mode_pipeline_manager = 'background';
Pipeline_opt.max_queued = 10;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
Pipeline_opt.flag_update = 1;
Pipeline_opt.path_logs = '/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/logs10';

psom_run_pipeline(pipeline,Pipeline_opt);
