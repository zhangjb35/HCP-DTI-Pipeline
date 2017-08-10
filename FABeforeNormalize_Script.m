
FA_Cell = g_ls('/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/Process/*/Diffusion/*FA.nii.gz');

for i = 1:length(FA_Cell)
    Job_Name = ['FABefore_' num2str(i)];
    pipeline.(Job_Name).command = 'g_BeforeNormalize(opt.FA)';
    pipeline.(Job_Name).opt.FA = FA_Cell{i};
end

psom_gb_vars

Pipeline_opt.mode = 'batch';
% Pipeline_opt.qsub_options = '-q all.q';
Pipeline_opt.mode_pipeline_manager = 'background';
Pipeline_opt.max_queued = 15;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
Pipeline_opt.flag_update = 1;
Pipeline_opt.path_logs = '/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/logs_BeforeNormalize';

psom_run_pipeline(pipeline,Pipeline_opt);