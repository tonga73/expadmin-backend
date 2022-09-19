import { PartialType } from '@nestjs/mapped-types';
import { CreateOfficeDto } from './create-office.dto';

import { IsString, IsOptional, IsNotEmpty, IsInt } from 'class-validator';
import { Exclude } from 'class-transformer';

export class UpdateOfficeDto extends PartialType(CreateOfficeDto) {
  @IsOptional()
  @Exclude()
  id: number;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  secretary: string;

  @IsInt()
  @IsOptional()
  courtId: number;
}
