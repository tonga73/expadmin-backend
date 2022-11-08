import {
  IsInt,
  IsString,
  IsEnum,
  IsBoolean,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';

import { Tracing, Priority, Note } from '@prisma/client';
export class CreateRecordDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsOptional()
  @IsString()
  @IsNotEmpty()
  order: string;

  @IsEnum(Tracing)
  @IsOptional()
  tracing: Tracing;

  @IsEnum(Priority)
  @IsOptional()
  priority: Priority;

  @IsBoolean()
  @IsOptional()
  archive: boolean;
}
