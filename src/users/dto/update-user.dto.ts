import { PartialType } from '@nestjs/mapped-types';
import { CreateUserDto } from './create-user.dto';
import {
  IsInt,
  IsString,
  IsEnum,
  IsBoolean,
  IsNotEmpty,
  IsOptional,
} from 'class-validator';
import { Exclude } from 'class-transformer';
import { Role } from '@prisma/client';

export class UpdateUserDto extends PartialType(CreateUserDto) {
  @IsOptional()
  @Exclude()
  id: number;

  @IsInt()
  @IsNotEmpty()
  @IsOptional()
  googleId: number;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
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
