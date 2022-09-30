import { PartialType } from '@nestjs/mapped-types';
import { CreateCourtDto } from './create-court.dto';

import { IsString, IsOptional, IsNotEmpty, IsInt } from 'class-validator';
import { Exclude } from 'class-transformer';

export class UpdateCourtDto extends PartialType(CreateCourtDto) {
  @IsOptional()
  @Exclude()
  id: number;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  city: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  judge: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  address: string;

  @IsInt()
  @IsOptional()
  districtId: number;
}
