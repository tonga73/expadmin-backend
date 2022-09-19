import { IsString, IsOptional, IsNotEmpty, IsInt } from 'class-validator';

export class CreateDistrictDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  city: string;
}
