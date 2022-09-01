import { IsInt, IsString, IsBoolean, IsOptional } from 'class-validator';
import { Exclude } from 'class-transformer';

export class UpdateRecordDto {
  @IsOptional()
  @Exclude()
  id: number;

  @IsString()
  @IsOptional()
  title: string;

  @IsString()
  @IsOptional()
  order: string;

  @IsBoolean()
  @IsOptional()
  archive: boolean;

  @IsString()
  @IsOptional()
  status: string;

  @IsString()
  @IsOptional()
  priority: string;

  @IsInt()
  @IsOptional()
  authorId: number;

  @IsInt()
  @IsOptional()
  districtId: number;
}
