
FA_Cell = g_ls('/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/Process/8*/*/*4normalize.nii.gz');

for i = 1:length(FA_Cell)
    Job_Name = ['fnirt_' num2str(i)];
    pipeline.(Job_Name).command = 'system([''fsl_reg '' opt.FA '' '' opt.target '' '' opt.ResultantFile '' -FA''])';
    pipeline.(Job_Name).opt.FA = FA_Cell{i};
    pipeline.(Job_Name).opt.target = '$FSLDIR/data/standard/FMRIB58_FA_1mm.nii.gz';
    [ParentFolder, FileName, ~] = fileparts(FA_Cell{i});
    pipeline.(Job_Name).opt.ResultantFile = [ParentFolder '/' FileName(1:end - 4) '_to_target'];
end

psom_gb_vars

Pipeline_opt.mode = 'batch';
% Pipeline_opt.qsub_options = '-q all.q';
Pipeline_opt.mode_pipeline_manager = 'batch';
Pipeline_opt.max_queued =20;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
Pipeline_opt.flag_update = 1;
Pipeline_opt.path_logs = '/lustre/zai/cuizaixu/DATA_HCP_Reading/Diffusion_20151225/llogs_FANormalize2';

psom_run_pipeline(pipeline,Pipeline_opt);