import { IsString, IsOptional, IsNotEmpty, IsInt } from 'class-validator';

export class CreateDistrictDto {
  @IsString()
  @IsNotEmpty()
  name: string;
}
