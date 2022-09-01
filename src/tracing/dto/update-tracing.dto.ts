import { IsInt, IsString, IsBoolean, IsOptional } from 'class-validator';
import { Exclude } from 'class-transformer';

export class UpdateTracingDto {
  @IsOptional()
  @Exclude()
  id: number;

  @IsString()
  @IsOptional()
  name: string;

  @IsInt()
  @IsOptional()
  recordId: number;
}
