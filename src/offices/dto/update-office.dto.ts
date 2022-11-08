import {
  IsInt,
  IsString,
  IsEnum,
  IsBoolean,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';
import { Exclude } from 'class-transformer';

export class UpdateOfficeDto {
  @IsOptional()
  @Exclude()
  id: number;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsInt()
  courtId: number;
}
