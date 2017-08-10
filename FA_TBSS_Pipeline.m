
FA_Cell = g_ls('/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/Process/*/Diffusion/*FA*to_target.nii.gz');
% saving_directory = '/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225';
% g_dismap( FA_Cell, saving_directory, 0.2 )

Mean_FA = '/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/TBSS/MeanData/mean_FA.nii.gz';
Dst_FilePath = '/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/TBSS/MeanData/mean_FA_skeleton_mask_dst.nii.gz';
for i = 1:length(FA_Cell)
    Job_Name = ['tbss_' num2str(i)];
    pipeline.(Job_Name).command = 'g_2skeleton(opt.para1, opt.para2, opt.para3, opt.para4, opt.para5)';
    pipeline.(Job_Name).opt.para1 = FA_Cell{i};
    pipeline.(Job_Name).opt.para2 = FA_Cell{i};
    pipeline.(Job_Name).opt.para3 = Mean_FA;
    pipeline.(Job_Name).opt.para4 = Dst_FilePath;
    pipeline.(Job_Name).opt.para5 = 0.2;
end

psom_gb_vars

Pipeline_opt.mode = 'batch';
% Pipeline_opt.qsub_options = '-q all.q';
Pipeline_opt.mode_pipeline_manager = 'batch';
Pipeline_opt.max_queued = 24;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
Pipeline_opt.flag_update = 1;
Pipeline_opt.path_logs = '/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/logs';

psom_run_pipeline(pipeline,Pipeline_opt);
