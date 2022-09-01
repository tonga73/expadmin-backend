import { IsInt, IsString, IsBoolean, IsOptional } from 'class-validator';
import { Exclude } from 'class-transformer';

import { Record } from '@prisma/client';

export class UpdateDistrictDto {
  @IsOptional()
  @Exclude()
  id: number;

  @IsString()
  @IsOptional()
  name: string;

  @IsString()
  @IsOptional()
  city: string;

  @IsOptional()
  records?: Record[];
}
