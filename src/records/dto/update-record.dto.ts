import { PartialType } from '@nestjs/mapped-types';
import { CreateRecordDto } from './create-record.dto';
import {
  IsInt,
  IsString,
  IsBoolean,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';
import { Exclude } from 'class-transformer';

export class UpdateRecordDto extends PartialType(CreateRecordDto) {
  @IsOptional()
  @Exclude()
  id: number;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsOptional()
  order: string;

  @IsBoolean()
  @IsOptional()
  archive: boolean;
}
