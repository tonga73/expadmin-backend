import {
  IsInt,
  IsString,
  IsEnum,
  IsBoolean,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';
export class CreateRecordDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsOptional()
  order: string;

  @IsBoolean()
  @IsOptional()
  archive: boolean;

  @IsString()
  @IsOptional()
  office: string;

  @IsInt()
  @IsOptional()
  courtId: number;
}
