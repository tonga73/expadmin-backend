import {
  IsInt,
  IsString,
  IsBoolean,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';

export class CreateRecordDto {
  @IsString()
  @IsNotEmpty()
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
