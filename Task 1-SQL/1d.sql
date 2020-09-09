select *
  from [dbo].[Job] j
  where j.[JobStatusId] = 1 and j.[JobStartDate] is not null