import {
  IsInt,
  IsString,
  IsEnum,
  IsBoolean,
  IsNotEmpty,
  IsOptional,
  IsDate,
} from 'class-validator';
import { Type } from 'class-transformer';

import { Prisma, Tracing, Priority, Note } from '@prisma/client';

export class QueryDto {
  @IsEnum(Tracing)
  @IsOptional()
  @IsNotEmpty()
  tracing: Tracing;

  @IsEnum(Priority)
  @IsOptional()
  @IsNotEmpty()
  priority: Priority;

  @IsBoolean()
  @IsOptional()
  @IsNotEmpty()
  archive: boolean;

  @IsString()
  @IsOptional()
  @IsNotEmpty()
  search: string;

  @IsEnum(Prisma.SortOrder)
  @IsOptional()
  @IsNotEmpty()
  updatedAt: Prisma.SortOrder;
}
