import { PartialType } from '@nestjs/mapped-types';
import { CreateDistrictDto } from './create-district.dto';

import { IsString, IsOptional, IsNotEmpty, IsInt } from 'class-validator';
import { Exclude } from 'class-transformer';

export class UpdateDistrictDto extends PartialType(CreateDistrictDto) {
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
}
