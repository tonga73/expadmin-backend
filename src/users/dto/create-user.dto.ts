import {
  IsInt,
  IsString,
  IsEnum,
  IsBoolean,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';
import { Role } from '@prisma/client';

export class CreateUserDto {
  @IsString()
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsOptional()
  name: string;

  @IsBoolean()
  @IsOptional()
  verified: boolean;

  @IsEnum(['USER', 'ADMIN'])
  @IsOptional()
  role: Role;
}
