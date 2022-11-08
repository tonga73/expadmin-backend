import {
  IsInt,
  IsString,
  IsEnum,
  IsBoolean,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';

import { ApiProperty } from '@nestjs/swagger';

import { Court } from '@prisma/client';

export class CreateOfficeDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsInt()
  @IsNotEmpty()
  courtId: number;
}
