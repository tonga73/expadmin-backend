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
  @IsString()
  @IsOptional()
  @IsNotEmpty()
  search: string;

  @IsEnum(Prisma.SortOrder)
  @IsOptional()
  @IsNotEmpty()
  name: Prisma.SortOrder;

  @IsEnum(Prisma.SortOrder)
  @IsOptional()
  @IsNotEmpty()
  order: Prisma.SortOrder;

  @IsEnum(Prisma.SortOrder)
  @IsOptional()
  @IsNotEmpty()
  favorite: Prisma.SortOrder;

  @IsEnum(Prisma.SortOrder)
  @IsOptional()
  @IsNotEmpty()
  updatedAt: Prisma.SortOrder;
}
